using AutoMapper;
using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class AnimeService : BaseCRUDService<Model.Anime, Database.Anime, AnimeSearchObject, AnimeInsertRequest, AnimeUpdateRequest>, IAnimeService
    {

        protected IGenreAnimeService _genreAnimeService;
        protected MagContext _context;

        public AnimeService(MagContext context, IMapper mapper, IGenreAnimeService genreAnimeService) : base(context, mapper)
        {
            _genreAnimeService = genreAnimeService;
            _context = context;
        }

        public override IQueryable<Database.Anime> AddFilter(IQueryable<Database.Anime> query, AnimeSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.Title))
            {
                query = query.Where(x => x.TitleEn.StartsWith(search.Title) || x.TitleJp.StartsWith(search.Title));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.TitleEn.Contains(search.FTS) || x.TitleJp.Contains(search.FTS));
            }

            if (search?.NewestFirst == true)
            {
                query = query.OrderByDescending(x => x.Id);
            }

            if (search?.Id != null)
            {
                query = query.Where(x => x.Id == search.Id);
            }

            if (search?.TopFirst == true)
            {
                query = query.OrderByDescending(anime => anime.Ratings.Count).ThenByDescending(anime => anime.Score);
            }

            if (search?.Ids != null)
            {
                query = query.Where(anime => search.Ids.Contains(anime.Id));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Anime> AddInclude(IQueryable<Database.Anime> query, AnimeSearchObject? search = null)
        {

            if (search?.GenresIncluded == true)
            {
                query = query.Include(x => x.GenreAnimes)
                             .ThenInclude(genres => genres.Genre);
            }

            return base.AddInclude(query, search);
        }

        public override async Task BeforeDelete(Database.Anime entity)
        {
            await _genreAnimeService.DeleteByAnimeId(entity.Id);
        }

        public async Task<List<PopularAnimeData>> GetMostPopularAnime()
        {
            var animeList = await _context.Animes.OrderByDescending(anime => anime.Ratings.Count).ThenByDescending(anime => anime.Score).Take(5).ToListAsync();

            List<PopularAnimeData> popularAnime = new List<PopularAnimeData>();

            foreach (var anime in animeList)
            {
                popularAnime.Add(new PopularAnimeData()
                {
                    AnimeTitleEN = anime.TitleEn,
                    AnimeTitleJP = anime.TitleJp,
                    Score = anime.Score,
                    NumberOfRatings = _context.Ratings.Where(rating => rating.AnimeId == anime.Id).Count()
                });
            }

            return popularAnime;
        }
    }
}

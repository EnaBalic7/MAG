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
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using static MAG.Services.AnimeService;

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

            if (search?.GenreIds != null)
            {
                foreach (var genreId in search.GenreIds)
                {
                    query = query.Where(anime => anime.GenreAnimes.Any(genreAnime => genreAnime.GenreId == genreId));
                }
            }

            if (search?.GetEmptyList == true)
            {
                query = query.Where(anime => false);
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
                    Score = (decimal)anime.Score,
                    NumberOfRatings = _context.Ratings.Where(rating => rating.AnimeId == anime.Id).Count()
                });
            }

            return popularAnime;
        }

        public class AnimeFeatureVector
        {
            public int AnimeId { get; set; }
            public List<int> GenreIds { get; set; } = new List<int>();
            public string Synopsis { get; set; }
        }

        public static class SimilarityService
        {
            public static double CalculateCosineSimilarity(AnimeFeatureVector anime1, AnimeFeatureVector anime2)
            {
                var genreSet = anime1.GenreIds.Union(anime2.GenreIds).ToHashSet();
                var genreVector1 = genreSet.Select(g => anime1.GenreIds.Contains(g) ? 1 : 0).ToList();
                var genreVector2 = genreSet.Select(g => anime2.GenreIds.Contains(g) ? 1 : 0).ToList();

                var dotProduct = genreVector1.Zip(genreVector2, (a, b) => a * b).Sum();
                var magnitude1 = Math.Sqrt(genreVector1.Sum(a => a * a));
                var magnitude2 = Math.Sqrt(genreVector2.Sum(a => a * a));

                var genreSimilarity = dotProduct / (magnitude1 * magnitude2);

                double synopsisSimilarity = 0;

                if (!string.IsNullOrEmpty(anime1.Synopsis) && !string.IsNullOrEmpty(anime2.Synopsis))
                {
                    synopsisSimilarity = CalculateTextSimilarity(anime1.Synopsis, anime2.Synopsis);
                }

                // Combines genre similarity and synopsis similarity
                return 0.5 * genreSimilarity + 0.5 * synopsisSimilarity;
            }

            private static double CalculateTextSimilarity(string text1, string text2)
            {
                var words1 = Regex.Split(text1.ToLower(), @"\W+").Distinct().ToList();
                var words2 = Regex.Split(text2.ToLower(), @"\W+").Distinct().ToList();

                var union = words1.Union(words2).Count();
                var intersection = words1.Intersect(words2).Count();

                return (double)intersection / union;
            }
        }

        // CONTENT-BASED FILTERING
        public async Task<PagedResult<Model.Anime>> Recommend(int userId)
        {
            var userPreferredGenres = await _context.PreferredGenres.Where(ug => ug.UserId == userId).Select(ug => ug.GenreId).ToListAsync();

            var userRatedAnime = await _context.Ratings.Where(ur => ur.UserId == userId && ur.RatingValue.HasValue && ur.RatingValue.Value >= 8).Include(ur => ur.Anime).ToListAsync();

            var userConstellationAnime = await _context.AnimeLists.Where(c => c.List.UserId == userId).Include(c => c.Anime).ToListAsync();

            // Get IDs of anime that user has already rated or added to constellation or nebula
            var userRatedAnimeIds = userRatedAnime.Select(ur => ur.Anime.Id).ToList();
            var userConstellationAnimeIds = userConstellationAnime.Select(c => c.Anime.Id).ToList();

            var userWatchlist = await _context.Watchlists.Where(w => w.UserId == userId).Include(w => w.AnimeWatchlists).FirstOrDefaultAsync();
            var userNebulaAnimeIds = userWatchlist?.AnimeWatchlists.Select(aw => aw.AnimeId).ToList();


            List<Database.Anime> allOtherAnime = new List<Database.Anime>();

            // Get all other anime
            if (userNebulaAnimeIds != null)
            {
                allOtherAnime = await _context.Animes
                                            .Include(a => a.GenreAnimes)
                                            .Where(a => !userRatedAnimeIds.Contains(a.Id) && !userConstellationAnimeIds.Contains(a.Id) && !userNebulaAnimeIds.Contains(a.Id))
                                            .ToListAsync();
            }
            else
            {
                allOtherAnime = await _context.Animes
                                           .Include(a => a.GenreAnimes)
                                           .Where(a => !userRatedAnimeIds.Contains(a.Id) && !userConstellationAnimeIds.Contains(a.Id))
                                           .ToListAsync();
            }

            var similarityScores = new List<Tuple<Database.Anime, double>>();

            PagedResult<Model.Anime> pagedResult = new PagedResult<Model.Anime>();

            foreach (var anime in allOtherAnime)
            {
                var featureVector = new AnimeFeatureVector
                {
                    AnimeId = anime.Id,
                    GenreIds = anime.GenreAnimes.Select(ga => ga.GenreId).ToList(),
                    Synopsis = anime.Synopsis
                };

                double similarity = 0;

                // Compares with preferred genres
                var genreVector = new AnimeFeatureVector { GenreIds = userPreferredGenres, Synopsis = "" };
                similarity += SimilarityService.CalculateCosineSimilarity(featureVector, genreVector);

                // Compares with highly rated anime
                foreach (var ratedAnime in userRatedAnime)
                {
                    var ratedFeatureVector = new AnimeFeatureVector
                    {
                        AnimeId = ratedAnime.Anime.Id,
                        GenreIds = ratedAnime.Anime.GenreAnimes.Select(ga => ga.GenreId).ToList(),
                        Synopsis = ratedAnime.Anime.Synopsis
                    };
                    similarity += SimilarityService.CalculateCosineSimilarity(featureVector, ratedFeatureVector);
                }

                // Compares with Constellation anime
                foreach (var constellationAnime in userConstellationAnime)
                {
                    var constellationFeatureVector = new AnimeFeatureVector
                    {
                        AnimeId = constellationAnime.Anime.Id,
                        GenreIds = constellationAnime.Anime.GenreAnimes.Select(ga => ga.GenreId).ToList(),
                        Synopsis = constellationAnime.Anime.Synopsis
                    };
                    similarity += SimilarityService.CalculateCosineSimilarity(featureVector, constellationFeatureVector);
                }

                similarityScores.Add(new Tuple<Database.Anime, double>(anime, similarity));
            }

            var recommendedAnimes = similarityScores.OrderByDescending(x => x.Item2)
                                                      .Select(x => x.Item1)
                                                      .Take(10)
                                                      .ToList();

            pagedResult.Result = _mapper.Map<List<Model.Anime>>(recommendedAnimes);
            pagedResult.Count = recommendedAnimes.Count;

            return pagedResult;
        }
    }
}

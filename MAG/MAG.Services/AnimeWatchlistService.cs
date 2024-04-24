using AutoMapper;
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
    public class AnimeWatchlistService : BaseCRUDService<Model.AnimeWatchlist, Database.AnimeWatchlist, AnimeWatchlistSearchObject, AnimeWatchlistInsertRequest, AnimeWatchlistUpdateRequest>, IAnimeWatchlistService
    {
        public AnimeWatchlistService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<AnimeWatchlist> AddFilter(IQueryable<AnimeWatchlist> query, AnimeWatchlistSearchObject? search = null)
        {
            if (search?.AnimeId != null)
            {
                query = query.Where(animeWatchlist => animeWatchlist.AnimeId == search.AnimeId);
            }

            if (search?.WatchlistId != null)
            {
                query = query.Where(animeWatchlist => animeWatchlist.WatchlistId == search.WatchlistId);
            }

            if (search?.WatchStatus != null)
            {
                query = query.Where(animeWatchlist => animeWatchlist.WatchStatus == search.WatchStatus);
            }

            if (search?.NewestFirst != null)
            {
                query = query.OrderByDescending(animeWatchlist => animeWatchlist.Id);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<AnimeWatchlist> AddInclude(IQueryable<AnimeWatchlist> query, AnimeWatchlistSearchObject? search = null)
        {
            if(search?.AnimeIncluded == true)
            {
                query = query.Include(animeWatchlist => animeWatchlist.Anime);
            }
            if (search?.GenresIncluded == true)
            {
                query = query.Include(animeWatchlist => animeWatchlist.Anime.GenreAnimes);
            }
            return base.AddInclude(query, search);
        }
    }
}

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
    public class AnimeListService : BaseCRUDService<Model.AnimeList, Database.AnimeList, AnimeListSearchObject, AnimeListInsertRequest, AnimeListUpdateRequest>, IAnimeListService
    {
        public AnimeListService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<AnimeList> AddFilter(IQueryable<AnimeList> query, AnimeListSearchObject? search = null)
        {
            if(search?.ListId != null)
            {
                query = query.Where(animeList => animeList.ListId ==  search.ListId);
            }

            if (search?.GetRandom == true)
            {
                query = query.OrderBy(animeList => Guid.NewGuid()).Take(1);
            }


            return base.AddFilter(query, search);
        }

        public override IQueryable<AnimeList> AddInclude(IQueryable<AnimeList> query, AnimeListSearchObject? search = null)
        {
            if(search?.IncludeAnime == true)
            {
                query = query.Include(animeList => animeList.Anime);
            }

            return base.AddInclude(query, search);
        }


    }
}

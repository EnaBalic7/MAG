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
        public AnimeService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Database.Anime> AddFilter(IQueryable<Database.Anime> query, AnimeSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                query = query.Where(x => x.TitleEn.StartsWith(search.Name) || x.TitleJp.StartsWith(search.Name));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.TitleEn.Contains(search.FTS) || x.TitleJp.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }
    }
}

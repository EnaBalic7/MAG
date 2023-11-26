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

            if (!string.IsNullOrWhiteSpace(search?.Title))
            {
                query = query.Where(x => x.TitleEn.StartsWith(search.Title) || x.TitleJp.StartsWith(search.Title));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.TitleEn.Contains(search.FTS) || x.TitleJp.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Anime> AddInclude(IQueryable<Database.Anime> query, AnimeSearchObject? search = null)
        {

            if (search.GenresIncluded == true)
            {
                query = query.Include(x => x.GenreAnimes)
                             .ThenInclude(genres => genres.Genre);
            }

            return base.AddInclude(query, search);
        }
    }
}

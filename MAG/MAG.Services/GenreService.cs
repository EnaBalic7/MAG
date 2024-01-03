using AutoMapper;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class GenreService : BaseCRUDService<Model.Genre, Database.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>, IGenreService
    {

        protected IGenreAnimeService _genreAnimeService;

        public GenreService(MagContext context, IMapper mapper, IGenreAnimeService genreAnimeService) : base(context, mapper)
        {
            _genreAnimeService = genreAnimeService;
        }

        public override IQueryable<Genre> AddFilter(IQueryable<Genre> query, GenreSearchObject? search = null)
        {
            if(search?.SortAlphabetically == true)
            {
                query = query.OrderBy(x => x.Name);
            }
            
            return base.AddFilter(query, search);
        }

        public override async Task BeforeDelete(Genre entity)
        {
            await _genreAnimeService.DeleteByGenreId(entity.Id);
        }
    }
}

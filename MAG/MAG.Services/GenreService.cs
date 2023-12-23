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
        public GenreService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Genre> AddFilter(IQueryable<Genre> query, GenreSearchObject? search = null)
        {
            if(search?.SortAlphabetically == true)
            {
                query = query.OrderBy(x => x.Name);
            }
            
            return base.AddFilter(query, search);
        }
    }
}

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
    public class PreferredGenreService : BaseCRUDService<Model.PreferredGenre, Database.PreferredGenre, PreferredGenreSearchObject, PreferredGenreInsertRequest, PreferredGenreUpdateRequest>, IPreferredGenreService
    {
        public PreferredGenreService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

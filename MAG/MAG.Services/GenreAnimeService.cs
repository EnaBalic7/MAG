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
    public class GenreAnimeService : BaseCRUDService<Model.GenreAnime, Database.GenreAnime, GenreAnimeSearchObject, GenreAnimeInsertRequest, GenreAnimeUpdateRequest>, IGenreAnimeService
    {
        public GenreAnimeService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

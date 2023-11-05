using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IGenreAnimeService : ICRUDService<Model.GenreAnime, GenreAnimeSearchObject, GenreAnimeInsertRequest, GenreAnimeUpdateRequest>
    {
    }
}

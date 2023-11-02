using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class GenreController : BaseCRUDController<Model.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>
    {
        public GenreController(IGenreService service) : base(service)
        {

        }
    }
}
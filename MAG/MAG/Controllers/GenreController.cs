using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Client;

namespace MAG.Controllers
{
    [ApiController]
    public class GenreController : BaseCRUDController<Model.Genre, GenreSearchObject, GenreInsertRequest, GenreUpdateRequest>
    {
        protected IGenreService _genreService;
        public GenreController(IGenreService service) : base(service)
        {
            _genreService = service;
        }

        [HttpGet("GetMostPopularGenres")]
        public async Task<List<PopularGenresData>> GetMostPopularGenres()
        {
            return await _genreService.GetMostPopularGenres();
        }
    }
}
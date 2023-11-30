using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class GenreAnimeController : BaseCRUDController<Model.GenreAnime, GenreAnimeSearchObject, GenreAnimeInsertRequest, GenreAnimeUpdateRequest>
    {
        protected readonly IGenreAnimeService _service;
        public GenreAnimeController(IGenreAnimeService service) : base(service)
        {
            _service = service;
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<GenreAnime> Update(int id, [FromBody] GenreAnimeUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [HttpDelete("DeleteByAnimeId/{animeId}")]
        public async Task<bool> DeleteByAnimeId(int animeId)
        {
           return await _service.DeleteByAnimeId(animeId);
        }

        [HttpDelete("DeleteByGenreId/{genreId}")]
        public async Task<bool> DeleteByGenreId(int genreId)
        {
            return await _service.DeleteByGenreId(genreId);
        }

    }
}
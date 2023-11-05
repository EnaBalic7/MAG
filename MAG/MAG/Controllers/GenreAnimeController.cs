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
        public GenreAnimeController(IGenreAnimeService service) : base(service)
        {

        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<GenreAnime> Update(int id, [FromBody] GenreAnimeUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
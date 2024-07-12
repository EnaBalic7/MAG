using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class PreferredGenreController : BaseCRUDController<Model.PreferredGenre, PreferredGenreSearchObject, PreferredGenreInsertRequest, PreferredGenreUpdateRequest>
    {
        private readonly IPreferredGenreService _service;
        public PreferredGenreController(IPreferredGenreService service) : base(service)
        {
            _service = service;
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<PreferredGenre> Update(int id, [FromBody] PreferredGenreUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [HttpPut("UpdatePrefGenres/{userId}")]
        public async Task<bool> UpdatePrefGenresForUser(int userId, [FromBody] List<PreferredGenreInsertRequest> newPrefGenres)
        {
            return await _service.UpdatePrefGenresForUser(userId, newPrefGenres);
        }
    }
}
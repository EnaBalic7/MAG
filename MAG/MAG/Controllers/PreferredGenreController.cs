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
        public PreferredGenreController(IPreferredGenreService service) : base(service)
        {

        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<PreferredGenre> Update(int id, [FromBody] PreferredGenreUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
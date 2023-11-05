using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class AnimeListController : BaseCRUDController<Model.AnimeList, AnimeListSearchObject, AnimeListInsertRequest, AnimeListUpdateRequest>
    {
        public AnimeListController(IAnimeListService service) : base(service)
        {

        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<AnimeList> Update(int id, [FromBody] AnimeListUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
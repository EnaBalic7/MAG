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
        protected readonly IAnimeListService _service;
        public AnimeListController(IAnimeListService service) : base(service)
        {
            _service = service;
        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<AnimeList> Update(int id, [FromBody] AnimeListUpdateRequest update)
        {
            return base.Update(id, update);
        }


        [HttpPut("UpdateLists/{animeId}")]
        public async Task<bool> UpdateListsForAnime(int animeId, [FromBody] List<AnimeListInsertRequest> newLists)
        {
            return await _service.UpdateListsForAnime(animeId, newLists);
        }
    }
}
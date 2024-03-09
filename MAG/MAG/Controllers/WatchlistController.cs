using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class WatchlistController : BaseCRUDController<Model.Watchlist, WatchlistSearchObject, WatchlistInsertRequest, WatchlistUpdateRequest>
    {
        public WatchlistController(IWatchlistService service) : base(service)
        {

        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<Watchlist> Update(int id, [FromBody] WatchlistUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
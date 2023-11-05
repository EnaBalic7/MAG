using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class AnimeWatchlistController : BaseCRUDController<Model.AnimeWatchlist, AnimeWatchlistSearchObject, AnimeWatchlistInsertRequest, AnimeWatchlistUpdateRequest>
    {
        public AnimeWatchlistController(IAnimeWatchlistService service) : base(service)
        {

        }
    }
}
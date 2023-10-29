using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class AnimeController : BaseCRUDController<Model.Anime, AnimeSearchObject, AnimeInsertRequest, AnimeUpdateRequest>
    {
        public AnimeController(IAnimeService service) : base(service)
        {

        }
    }
}
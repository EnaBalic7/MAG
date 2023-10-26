using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class AnimeController : BaseController<Model.Anime, AnimeSearchObject>
    {
        public AnimeController(IAnimeService service) : base(service)
        {

        }
    }
}
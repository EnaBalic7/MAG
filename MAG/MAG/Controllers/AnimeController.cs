using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AnimeController : ControllerBase
    {

        private readonly IAnimeService _service;
        public AnimeController(IAnimeService service)
        {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<Model.Anime> Get()
        {
            return _service.Get();
        }

    }
}
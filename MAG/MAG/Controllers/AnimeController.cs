using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class AnimeController : BaseCRUDController<Model.Anime, AnimeSearchObject, AnimeInsertRequest, AnimeUpdateRequest>
    {
        protected IAnimeService _animeService;
        public AnimeController(IAnimeService service) : base(service)
        {
            _animeService = service;
        }

        [HttpGet("GetMostPopularAnime")]
        public async Task<List<PopularAnimeData>> GetMostPopularAnime()
        {
            return await _animeService.GetMostPopularAnime();
        }
    }
}
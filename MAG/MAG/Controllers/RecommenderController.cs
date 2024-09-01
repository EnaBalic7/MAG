using MAG.Model;
using MAG.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    public class RecommenderController
    {
        private readonly IRecommenderService _recommenderService;


        public RecommenderController(IRecommenderService service)
        {
            _recommenderService = service;
        }

        [Authorize]
        [HttpGet("Recommender/{animeId}")]
        public virtual async Task<Model.Recommender?> Get(int animeId, CancellationToken cancellationToken = default)
        {
            return await _recommenderService.GetById(animeId, cancellationToken);
        }

        [Authorize]
        [HttpPost("TrainModelAsync")]
        public virtual async Task<PagedResult<Model.Recommender>> TrainModel(CancellationToken cancellationToken = default)
        {
            return await _recommenderService.TrainAnimeModelAsync(cancellationToken);
        }

        [Authorize]
        [HttpDelete("ClearRecommendations")]
        public virtual async Task ClearRecommendations(CancellationToken cancellationToken = default)
        {
            await _recommenderService.DeleteAllRecommendations();
        }

    }
}

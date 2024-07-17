using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IRecommenderService : ICRUDService<Model.Recommender, RecommenderSearchObject, RecommenderInsertRequest, RecommenderUpdateRequest>
    {
        Task<Model.Recommender?> GetById(int id, CancellationToken cancellationToken = default);
        Task<List<Model.Recommender>> TrainAnimeModelAsync(CancellationToken cancellationToken = default);
        Task DeleteAllRecommendations(CancellationToken cancellationToken = default);
    }
}

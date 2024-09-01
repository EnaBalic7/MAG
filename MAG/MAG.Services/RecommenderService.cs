using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using MAG.Model;
using Microsoft.ML.Trainers;

namespace MAG.Services
{
      public class RecommenderService : BaseCRUDService<Model.Recommender, Database.Recommender,  RecommenderSearchObject,RecommenderInsertRequest, RecommenderUpdateRequest>, IRecommenderService
      {
          protected readonly IMapper _mapper;
          private readonly MagContext _context;
        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public RecommenderService(IMapper mapper, MagContext context) : base(context, mapper)
          {
              _mapper = mapper;
              _context = context;
          }
     
          public async Task<Model.Recommender?> GetById(int animeId, CancellationToken cancellationToken = default)
          {
              var entity = await _context.Recommenders.FirstOrDefaultAsync(r => r.AnimeId == animeId, cancellationToken);

              if (entity is null)
                  return null;

              return _mapper.Map<Model.Recommender>(entity);
          }
            
          
          public List<Model.Anime> Recommend(int animeId)
          {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var tmpData = _context.Watchlists.Include(w => w.AnimeWatchlists).ToList();

                    var data = new List<AnimeRecommendation>();

                    foreach (var x in tmpData)
                    {
                        if (x.AnimeWatchlists.Count > 1)
                        {
                            var distinctItemId = x.AnimeWatchlists.Select(y => y.AnimeId).ToList();

                            distinctItemId?.ForEach(y =>
                            {
                                var relatedItems = x.AnimeWatchlists.Where(z => z.AnimeId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new AnimeRecommendation()
                                    {
                                        AnimeId = (uint)y,
                                        CoAnimeId = (uint)z.AnimeId,
                                    });
                                }
                            });
                        }
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(AnimeRecommendation.AnimeId);
                    options.MatrixRowIndexColumnName = nameof(AnimeRecommendation.CoAnimeId);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;

                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }
            }

            var animes = _context.Animes.Where(x => x.Id != animeId).ToList();

            var predictionResult = new List<Tuple<Database.Anime, float>>();

            foreach (var anime in animes)
            {

                var predictionengine = mlContext.Model.CreatePredictionEngine<AnimeRecommendation, CoAnimePrediction>(model);
                var prediction = predictionengine.Predict(
                                         new AnimeRecommendation()
                                         {
                                             AnimeId = (uint)animeId,
                                             CoAnimeId = (uint)anime.Id
                                         });


                predictionResult.Add(new Tuple<Database.Anime, float>(anime, prediction.Score));
            }


            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return _mapper.Map<List<Model.Anime>>(finalResult);
        }
     
          public async Task<PagedResult<Model.Recommender>> TrainAnimeModelAsync(CancellationToken cancellationToken = default)
          {
              var animes = await _context.Animes.ToListAsync(cancellationToken);
              var numberOfRecords = await _context.AnimeWatchlists.CountAsync(cancellationToken);
     
              if (animes.Count > 4 && numberOfRecords > 8)
              {
                  List<Database.Recommender> recommendList = new List<Database.Recommender>();
     
                  foreach (var anime in animes)
                  {
                      var recommendedAnimes = Recommend(anime.Id);
     
                      var resultRecommend = new Database.Recommender()
                      {
                          AnimeId = anime.Id,
                          CoAnimeId1 = recommendedAnimes[0].Id,
                          CoAnimeId2 = recommendedAnimes[1].Id,
                          CoAnimeId3 = recommendedAnimes[2].Id
                      };
                      recommendList.Add(resultRecommend);
                  }
     
                  await CreateNewRecommendation(recommendList, cancellationToken);
                  await _context.SaveChangesAsync();
     
                  return _mapper.Map<PagedResult<Model.Recommender>>(recommendList);
              }
              else
              {
                  throw new Exception("Not enough data to generate recommendations.");
              }
          }
     
         public async Task DeleteAllRecommendations(CancellationToken cancellationToken = default)
         {
              await _context.Recommenders.ExecuteDeleteAsync(cancellationToken);
         }
     
          public async Task CreateNewRecommendation(List<Database.Recommender> results, CancellationToken cancellationToken = default)
          {
              var existingRecommendations = await _context.Recommenders.ToListAsync();
              var animeCount = await _context.Animes.CountAsync(cancellationToken);
              var recommendationCount = await _context.Recommenders.CountAsync();
     
              if (recommendationCount != 0)
              {
                  if (recommendationCount > animeCount)
                  {
                      for (int i = 0; i < animeCount; i++)
                      {
                          existingRecommendations[i].AnimeId = results[i].AnimeId;
                          existingRecommendations[i].CoAnimeId1 = results[i].CoAnimeId1;
                          existingRecommendations[i].CoAnimeId2 = results[i].CoAnimeId2;
                          existingRecommendations[i].CoAnimeId3 = results[i].CoAnimeId3;
                      }
     
                      for (int i = animeCount; i < recommendationCount; i++)
                      {
                          _context.Recommenders.Remove(existingRecommendations[i]);
                      }
                  }
                  else
                  {
                      for (int i = 0; i < recommendationCount; i++)
                      {
                          existingRecommendations[i].AnimeId = results[i].AnimeId;
                          existingRecommendations[i].CoAnimeId1 = results[i].CoAnimeId1;
                          existingRecommendations[i].CoAnimeId2 = results[i].CoAnimeId2;
                          existingRecommendations[i].CoAnimeId3 = results[i].CoAnimeId3;
                      }
                      var num = results.Count - recommendationCount;
     
                      if (num > 0)
                      {
                          for (int i = results.Count - num; i < results.Count; i++)
                          {
                              await _context.Recommenders.AddAsync(results[i]);
                          }
                      }
                  }
              }
              else
              {
                  await _context.Recommenders.AddRangeAsync(results);
              }
          }
      }

    }



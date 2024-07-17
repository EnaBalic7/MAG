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

namespace MAG.Services
{
      public class RecommenderService : BaseCRUDService<Model.Recommender, Database.Recommender,  RecommenderSearchObject,RecommenderInsertRequest, RecommenderUpdateRequest>, IRecommenderService
      {
          protected readonly IMapper _mapper;
          private readonly MagContext _context;
     
          public RecommenderService(IMapper mapper, MagContext context) : base(context, mapper)
          {
              _mapper = mapper;
              _context = context;
          }
     
          public async Task<Model.Recommender?> GetById(int id, CancellationToken cancellationToken = default)
          {
              var entity = await _context.Animes
                  .Include(a => a.GenreAnimes)
                  .FirstOrDefaultAsync(a => a.Id == id, cancellationToken);

              if (entity is null)
                  return null;

              return _mapper.Map<Model.Recommender>(entity);
          }
            
          // Content-based filtering
          public List<Model.Anime> Recommend(int userId)
          {
              var user = _context.Users
                  .Include(u => u.Ratings)
                  .ThenInclude(r => r.Anime)
                  .Include(u => u.PreferredGenres)
                  .Include(u => u.Lists)
                  .FirstOrDefault(u => u.Id == userId);
     
              if (user == null) return new List<Model.Anime>();
     
              // Get anime IDs that the user has highly rated or added to Constellation (List)
              var highlyRatedAnimeIds = user.Ratings
                  .Where(r => r.RatingValue >= 8.0m)
                  .Select(r => r.AnimeId)
                  .ToList();
     
              var constellationAnimeIds = user.Lists
                  .Select(a => a.Id)
                  .ToList();
     
              var preferredGenreIds = user.PreferredGenres
                  .Select(g => g.Id)
                  .ToList();
     
              // Find anime similar to the highly rated and constellation anime
              var recommendedAnime = _context.Animes
                  .Include(a => a.GenreAnimes)
                  .Where(a => highlyRatedAnimeIds.Contains(a.Id)
                           || constellationAnimeIds.Contains(a.Id)
                           || a.GenreAnimes.Any(ga => preferredGenreIds.Contains(ga.GenreId)))
                  .Distinct()
                  .ToList();
     
              return _mapper.Map<List<Model.Anime>>(recommendedAnime);
          }
     
          public List<Model.Anime> RecommendForNewUser(List<int> preferredGenreIds)
          {
              var recommendedAnime = _context.Animes
                  .Include(a => a.GenreAnimes)
                  .Where(a => a.GenreAnimes.Any(ga => preferredGenreIds.Contains(ga.GenreId)))
                  .Distinct()
                  .ToList();
     
              return _mapper.Map<List<Model.Anime>>(recommendedAnime);
          }
     
          public async Task<List<Model.Recommender>> TrainAnimeModelAsync(CancellationToken cancellationToken = default)
          {
              var animes = await _context.Animes.ToListAsync(cancellationToken);
              var ratingCount = await _context.Ratings.CountAsync(cancellationToken);
     
              if (animes.Count > 4 && ratingCount > 8)
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
     
                  return _mapper.Map<List<Model.Recommender>>(recommendList);
              }
              else
              {
                  throw new Exception("Not enough data to generate recommendations");
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



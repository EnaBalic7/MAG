using AutoMapper;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class RatingService : BaseCRUDService<Model.Rating, Database.Rating, RatingSearchObject, RatingInsertRequest, RatingUpdateRequest>, IRatingService
    {
        protected MagContext _context;
        public RatingService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }

        public override Task AfterInsert(Database.Rating entity, RatingInsertRequest insert)
        {
            UpdateAnimeScore(entity.AnimeId);
            return base.AfterInsert(entity, insert);
        }

        public override Task AfterUpdate(Database.Rating entity, RatingUpdateRequest update)
        {
            UpdateAnimeScore(entity.AnimeId);
            return base.AfterUpdate(entity, update);
        }

        public override Task AfterDelete(Database.Rating entity)
        {
            UpdateAnimeScore(entity.AnimeId);
            return base.AfterDelete(entity);
        }

        public void UpdateAnimeScore(int animeId)
        {
            var anime = _context.Animes.Where(a => a.Id == animeId).FirstOrDefault();
            
            if(anime != null)
            {
                var averageScore = CalculateAnimeScore(anime.Id);
                anime.Score = averageScore;

                _context.SaveChanges();
            }
        }

        public decimal CalculateAnimeScore(int animeId)
        {
            var ratings = _context.Ratings.Where(r => r.AnimeId == animeId).ToList();
            if (ratings.Any())
            {
                return ratings.Average(r => (decimal)r.RatingValue);
            }
            return 0.0m;
        }

        public override IQueryable<Rating> AddFilter(IQueryable<Rating> query, RatingSearchObject? search = null)
        {
            if (search?.Rating != null)
            {
                query = query.Where(x => x.RatingValue == search.Rating);
            }
              
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.ReviewText.Contains(search.FTS));
            }

            if (search?.UserId != null)
            {
                query = query.Where(x => x.UserId == search.UserId);
            }

            if (search?.AnimeId != null)
            {
                query = query.Where(x => x.AnimeId == search.AnimeId);
            }

            if (search?.NewestFirst == true)
            {
                query = query.OrderByDescending(x => x.DateAdded);
            }

            if (search?.TakeItems != null)
            {
                query = query.Take((int)search.TakeItems);
            }

            return base.AddFilter(query, search);
        }
    }
}

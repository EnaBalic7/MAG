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
        public RatingService(MagContext context, IMapper mapper) : base(context, mapper)
        {
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

            return base.AddFilter(query, search);
        }
    }
}

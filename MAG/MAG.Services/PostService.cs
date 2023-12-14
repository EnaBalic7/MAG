using AutoMapper;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class PostService : BaseCRUDService<Model.Post, Database.Post, PostSearchObject, PostInsertRequest, PostUpdateRequest>, IPostService
    {
        public PostService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Post> AddFilter(IQueryable<Post> query, PostSearchObject? search = null)
        {

            if (search?.ClubId != null)
            {
                query = query.Where(x => x.ClubId == search.ClubId);
            }

            if (search?.UserId != null)
            {
                query = query.Where(x => x.UserId == search.UserId);
            }

            if (search?.NewestFirst == true)
            {
                query = query.OrderByDescending(x => x.Id);
            }

            return base.AddFilter(query, search);
        }
    }
}

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
    public class PostService : BaseCRUDService<Model.Post, Database.Post, PostSearchObject, PostInsertRequest, PostUpdateRequest>, IPostService
    {

        protected ICommentService _commentService;

        public PostService(MagContext context, IMapper mapper, ICommentService commentService) : base(context, mapper)
        {
            _commentService = commentService;
        }

        public override IQueryable<Post> AddInclude(IQueryable<Post> query, PostSearchObject? search = null)
        {
            if(search?.CommentsIncluded == true)
            {
                query = query.Include(post => post.Comments);
            }
            
            return base.AddInclude(query, search);
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

            if(search?.Id != null)
            {
                query = query.Where(x => x.Id == search.Id);
            }

            return base.AddFilter(query, search);
        }

        public override async Task BeforeDelete(Post entity)
        {
           await _commentService.DeleteAllCommentsByPostId(entity.Id);
        }

    }
}

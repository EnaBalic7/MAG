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
    public class UserPostActionService : BaseCRUDService<Model.UserPostAction, Database.UserPostAction, UserPostActionSearchObject, UserPostActionInsertRequest, UserPostActionUpdateRequest>, IUserPostActionService
    {
        protected MagContext _context;
        protected IMapper _mapper;
        public UserPostActionService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public override IQueryable<UserPostAction> AddFilter(IQueryable<UserPostAction> query, UserPostActionSearchObject? search = null)
        {
            if(search?.UserId != null)
            {
                query = query.Where(upa => upa.UserId == search.UserId);
            }
            
            return base.AddFilter(query, search);
        }

        public async Task<bool> PostUserAction(int postId, UserPostActionInsertRequest userPostAction, string username)
        {
            var user = await _context.Users.SingleOrDefaultAsync(u => u.Username == username);

            if (user == null)
            {
                return false;
            }

            var post = await _context.Posts.Include(p => p.UserPostActions).SingleOrDefaultAsync(p => p.Id == postId);

            if (post == null)
            {
                return false;
            }

            var existingAction = post.UserPostActions.SingleOrDefault(a => a.UserId == user.Id);
            if (existingAction != null)
            {
                _context.UserPostActions.Remove(existingAction);
                if (existingAction.Action == "like")
                {
                    post.LikesCount--;
                }
                else if (existingAction.Action == "dislike")
                {
                    post.DislikesCount--;
                }
            }

            if (userPostAction.Action == "like")
            {
                post.LikesCount++;
            }
            else if (userPostAction.Action == "dislike")
            {
                post.DislikesCount++;
            }

            userPostAction.UserId = user.Id;
            userPostAction.PostId = postId;
            _context.UserPostActions.Add(_mapper.Map<Database.UserPostAction>(userPostAction));
            await _context.SaveChangesAsync();

            return true;
        }

   
    }
}

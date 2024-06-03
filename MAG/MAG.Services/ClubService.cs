using AutoMapper;
using MAG.Model;
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
    public class ClubService : BaseCRUDService<Model.Club, Database.Club, ClubSearchObject, ClubInsertRequest, ClubUpdateRequest>, IClubService
    {

        protected IPostService _postService;
        protected ICommentService _commentService;
        protected IClubUserService _clubUserService;
        public ClubService(MagContext context, IMapper mapper, IPostService postService, ICommentService commentService, IClubUserService clubUserService) : base(context, mapper)
        {
            var clubs = context.Clubs.ToList();

            foreach (var club in clubs)
            {
                var memberCount = context.ClubUsers.Count(cu => cu.ClubId == club.Id);

                club.MemberCount = memberCount;
            }

            context.SaveChanges();
            _postService = postService;
            _commentService = commentService;
            _clubUserService = clubUserService;
        }

        public override IQueryable<Database.Club> AddFilter(IQueryable<Database.Club> query, ClubSearchObject? search = null)
        {
            if(search?.Name != null)
            {
                query = query.Where(club => club.Name.Contains(search.Name));
            }

            if (search?.ClubId != null)
            {
                query = query.Where(club => club.Id == search.ClubId);
            }

            if (search?.UserId != null && search?.GetJoinedClubs != true)
            {
                query = query.Where(club => club.OwnerId == search.UserId);
            }

            if (search?.OrderByMemberCount == true)
            {
                query = query.OrderByDescending(club => club.MemberCount);
            }

            if (search?.GetJoinedClubs == true && search?.UserId != null)
            {
                query = query.Where(club => club.OwnerId != search.UserId);

                query = query.Where(club => club.ClubUsers.Any(clubUser => clubUser.UserId == search.UserId));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Club> AddInclude(IQueryable<Database.Club> query, ClubSearchObject? search = null)
        {
            if(search?.CoverIncluded == true)
            {
                query = query.Include(cover => cover.Cover);
            }
            
            return base.AddInclude(query, search);
        }

        public override async Task BeforeDelete(Database.Club entity)
        {
            var posts = _context.Posts.Where(post => post.ClubId == entity.Id).ToList();

            foreach (var post in posts)
            {
                await _commentService.DeleteAllCommentsByPostId(post.Id);
            }

            await _postService.DeleteByClubId(entity.Id);

            await _clubUserService.DeleteByClubId(entity.Id);

            // Implement cover deletion as well
          
        }
    }
}

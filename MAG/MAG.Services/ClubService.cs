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
    public class ClubService : BaseCRUDService<Model.Club, Database.Club, ClubSearchObject, ClubInsertRequest, ClubUpdateRequest>, IClubService
    {
        public ClubService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            var clubs = context.Clubs.ToList();

            foreach (var club in clubs)
            {
                var memberCount = context.ClubUsers.Count(cu => cu.ClubId == club.Id);

                club.MemberCount = memberCount;
            }

            context.SaveChanges();

        }

        public override IQueryable<Club> AddFilter(IQueryable<Club> query, ClubSearchObject? search = null)
        {
            if(search?.Name != null)
            {
                query = query.Where(club => club.Name.Contains(search.Name));
            }

            if (search?.ClubId != null)
            {
                query = query.Where(club => club.Id == search.ClubId);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Club> AddInclude(IQueryable<Club> query, ClubSearchObject? search = null)
        {
            if(search?.CoverIncluded == true)
            {
                query = query.Include(cover => cover.Cover);
            }
            
            return base.AddInclude(query, search);
        }
    }
}

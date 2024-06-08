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
    public class ClubUserService : BaseCRUDService<Model.ClubUser, Database.ClubUser, ClubUserSearchObject, ClubUserInsertRequest, ClubUserUpdateRequest>, IClubUserService
    {
        public ClubUserService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<ClubUser> AddFilter(IQueryable<ClubUser> query, ClubUserSearchObject? search = null)
        {
            
            if(search?.ClubId != null)
            {
                query = query.Where(clubUser => clubUser.ClubId == search.ClubId);
            }

            if (search?.UserId != null)
            {
                query = query.Where(clubUser => clubUser.UserId == search.UserId);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<ClubUser> AddInclude(IQueryable<ClubUser> query, ClubUserSearchObject? search = null)
        {
            if(search?.ClubIncluded == true)
            {
                query = query.Include(club => club.Club);
            }

            return base.AddInclude(query, search);
        }

    }
}

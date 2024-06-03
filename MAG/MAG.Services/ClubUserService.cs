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

        public override IQueryable<ClubUser> AddInclude(IQueryable<ClubUser> query, ClubUserSearchObject? search = null)
        {
            if(search.ClubIncluded == true)
            {
                query = query.Include(club => club.Club);
            }

            return base.AddInclude(query, search);
        }

        public async Task<bool> DeleteByClubId(int clubId)
        {
            var clubUserList = _context.ClubUsers.Where(clubUser => clubUser.ClubId == clubId).ToList();

            _context.RemoveRange(clubUserList);

            await _context.SaveChangesAsync();

            return true;
        }
    }
}

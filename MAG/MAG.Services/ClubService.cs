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

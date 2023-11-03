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
    public class ClubService : BaseCRUDService<Model.Club, Database.Club, ClubSearchObject, ClubInsertRequest, ClubUpdateRequest>, IClubService
    {
        public ClubService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }
    }
}

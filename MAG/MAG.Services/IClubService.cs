using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IClubService : ICRUDService<Model.Club, ClubSearchObject, ClubInsertRequest, ClubUpdateRequest>
    {
    }
}

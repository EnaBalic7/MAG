using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class ClubController : BaseCRUDController<Model.Club, ClubSearchObject, ClubInsertRequest, ClubUpdateRequest>
    {
        public ClubController(IClubService service) : base(service)
        {

        }
    }
}
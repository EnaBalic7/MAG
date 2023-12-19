using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class ClubCoverController : BaseCRUDController<Model.ClubCover, ClubCoverSearchObject, ClubCoverInsertRequest, ClubCoverUpdateRequest>
    {
        public ClubCoverController(IClubCoverService service) : base(service)
        {

        }
    }
}
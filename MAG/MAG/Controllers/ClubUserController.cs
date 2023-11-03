using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class ClubUserController : BaseCRUDController<Model.ClubUser, ClubUserSearchObject, ClubUserInsertRequest, ClubUserUpdateRequest>
    {
        public ClubUserController(IClubUserService service) : base(service)
        {

        }

        [ApiExplorerSettings(IgnoreApi = true)]
        public override Task<ClubUser> Update(int id, [FromBody] ClubUserUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
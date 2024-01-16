using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class UserRoleController : BaseCRUDController<Model.UserRole, UserRoleSearchObject, UserRoleInsertRequest, UserRoleUpdateRequest>
    {
        public UserRoleController(IUserRoleService service) : base(service)
        {

        }

        [AllowAnonymous]
        public override Task<UserRole> Insert([FromBody] UserRoleInsertRequest insert)
        {
            return base.Insert(insert);
        }
    }
}
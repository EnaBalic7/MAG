using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class RoleController : BaseCRUDController<Model.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>
    {
        public RoleController(IRoleService service) : base(service)
        {

        }
    }
}
using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IRoleService : ICRUDService<Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>
    {
    }
}

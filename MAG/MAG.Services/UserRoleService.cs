using AutoMapper;
using MAG.Model;
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
    public class UserRoleService : BaseCRUDService<Model.UserRole, Database.UserRole, BaseSearchObject, UserRoleInsertRequest, UserRoleUpdateRequest>, IUserRoleService
    {
        protected MagContext _context;
        public UserRoleService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }

    }
}

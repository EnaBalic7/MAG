using AutoMapper;
using MAG.Model;
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
    public class UserRoleService : BaseCRUDService<Model.UserRole, Database.UserRole, UserRoleSearchObject, UserRoleInsertRequest, UserRoleUpdateRequest>, IUserRoleService
    {
        protected MagContext _context;
        public UserRoleService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }

        public override IQueryable<Database.UserRole> AddInclude(IQueryable<Database.UserRole> query, UserRoleSearchObject? search = null)
        {
            if(search.RoleIncluded == true)
            {
                query = query.Include(role => role.Role);
            }

            return base.AddInclude(query, search);
        }
    }
}

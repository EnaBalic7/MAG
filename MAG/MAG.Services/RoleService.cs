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
    public class RoleService : BaseCRUDService<Model.Role, Database.Role, RoleSearchObject, RoleInsertRequest, RoleUpdateRequest>, IRoleService
    {
        public RoleService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Database.Role> AddFilter(IQueryable<Database.Role> query, RoleSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.Name))
            {
                query = query.Where(x => x.Name.StartsWith(search.Name));
            }

            return base.AddFilter(query, search);
        }
    }
}

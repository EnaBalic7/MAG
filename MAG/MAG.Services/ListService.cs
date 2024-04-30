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
    public class ListService : BaseCRUDService<Model.List, Database.List, ListSearchObject, ListInsertRequest, ListUpdateRequest>, IListService
    {
        protected readonly IAnimeListService _animeListService;
        public ListService(MagContext context, IMapper mapper, IAnimeListService animeListService) : base(context, mapper)
        {
            _animeListService = animeListService;
        }

        public override async Task BeforeDelete(List entity)
        {
             await _animeListService.DeleteByListId(entity.Id);
        }

        public override IQueryable<List> AddFilter(IQueryable<List> query, ListSearchObject? search = null)
        {
            if(search?.Name != null)
            {
                query = query.Where(list => list.Name.Contains(search.Name));
            }
            if (search?.NewestFirst != null)
            {
                query = query.OrderByDescending(list => list.Id);
            }
            if (search?.UserId != null)
            {
                query = query.Where(list => list.UserId == search.UserId);
            }

            return base.AddFilter(query, search);
        }
    }
}

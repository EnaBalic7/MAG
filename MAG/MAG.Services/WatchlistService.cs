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
    public class WatchlistService : BaseCRUDService<Model.Watchlist, Database.Watchlist, WatchlistSearchObject, WatchlistInsertRequest, WatchlistUpdateRequest>, IWatchlistService
    {
        public WatchlistService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Watchlist> AddFilter(IQueryable<Watchlist> query, WatchlistSearchObject? search = null)
        {
            if(search?.UserId != null)
            {
                query = query.Where(watchlist => watchlist.UserId == search.UserId);
            }

            return base.AddFilter(query, search);
        }
    }
}

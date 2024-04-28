using AutoMapper;
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
    public class AnimeListService : BaseCRUDService<Model.AnimeList, Database.AnimeList, AnimeListSearchObject, AnimeListInsertRequest, AnimeListUpdateRequest>, IAnimeListService
    {
        protected MagContext _context;
        public AnimeListService(MagContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }

        public override IQueryable<AnimeList> AddFilter(IQueryable<AnimeList> query, AnimeListSearchObject? search = null)
        {
            if (search?.AnimeId != null)
            {
                query = query.Where(animeList => animeList.AnimeId == search.AnimeId);
            }

            if (search?.ListId != null)
            {
                query = query.Where(animeList => animeList.ListId ==  search.ListId);
            }

            if (search?.GetRandom == true)
            {
                query = query.OrderBy(animeList => Guid.NewGuid()).Take(1);
            }


            return base.AddFilter(query, search);
        }

        public override IQueryable<AnimeList> AddInclude(IQueryable<AnimeList> query, AnimeListSearchObject? search = null)
        {
            if(search?.IncludeAnime == true)
            {
                query = query.Include(animeList => animeList.Anime);
            }

            return base.AddInclude(query, search);
        }

        public async Task<bool> UpdateListsForAnime(int animeId, List<AnimeListInsertRequest> newLists)
        {
            await DeleteByAnimeId(animeId);

            var entities = newLists.Select(insert => _mapper.Map<Database.AnimeList>(insert));

            _context.AnimeLists.AddRange(entities);

            await _context.SaveChangesAsync();

            return true;
        }

        public async Task<bool> DeleteByAnimeId(int animeId)
        {
            var set = _context.Set<Database.AnimeList>();

            var entityList = await set.Where(animeList => animeList.AnimeId == animeId).ToListAsync();

            if (entityList.Count() != 0)
            {
                set.RemoveRange(entityList);

                await _context.SaveChangesAsync();

                return true;
            }

            return false;
        }
    }
}

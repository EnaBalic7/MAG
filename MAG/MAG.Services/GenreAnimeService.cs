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
    public class GenreAnimeService : BaseCRUDService<Model.GenreAnime, Database.GenreAnime, GenreAnimeSearchObject, GenreAnimeInsertRequest, GenreAnimeUpdateRequest>, IGenreAnimeService
    {
        protected MagContext _context;
        protected IMapper _mapper { get; set; }
        public GenreAnimeService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<Model.GenreAnime> DeleteAllGenres(int animeId)
        {
            var set = _context.Set<Database.GenreAnime>();

            var entity = await set.Where(x => x.AnimeId == animeId).ToListAsync();

            if (entity != null)
            {
                set.RemoveRange(entity);
            }
            else
            {
                throw new UserException($"There is no entity in table [{set.GetType().ToString().Split('[', ']')[1]}] with provided animeId [{animeId}]");
            }

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.GenreAnime>(entity);

        }
    }
}

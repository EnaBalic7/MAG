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
            _context = context;
            _mapper = mapper;
        }

        public async Task<bool> DeleteByAnimeId(int animeId)
        {
            var set = _context.Set<Database.GenreAnime>();
            
            var entityList = await set.Where(x => x.AnimeId == animeId).ToListAsync();

            if (entityList.Count() != 0)
            {
                set.RemoveRange(entityList);

                await _context.SaveChangesAsync();

                return true;
            }

            return false;

        }
        public async Task<bool> DeleteByGenreId(int genreId)
        {
            var set = _context.Set<Database.GenreAnime>();

            var entityList = await set.Where(x => x.GenreId == genreId).ToListAsync();

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

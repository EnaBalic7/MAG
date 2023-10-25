using AutoMapper;
using MAG.Model;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class AnimeService : IAnimeService
    {
        MyAnimeGalaxyContext _context;
        public IMapper _mapper { get; set; }

        public AnimeService(MyAnimeGalaxyContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<List<Model.Anime>> Get()
        {
            var entityList = await _context.Animes.ToListAsync();

            return _mapper.Map<List<Model.Anime>>(entityList);
        }
    }
}

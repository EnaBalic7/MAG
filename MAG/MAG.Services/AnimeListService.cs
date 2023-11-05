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
    public class AnimeListService : BaseCRUDService<Model.AnimeList, Database.AnimeList, AnimeListSearchObject, AnimeListInsertRequest, AnimeListUpdateRequest>, IAnimeListService
    {
        public AnimeListService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }


    }
}

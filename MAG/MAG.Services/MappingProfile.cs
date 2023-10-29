using AutoMapper;
using MAG.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        { 
            CreateMap<Database.Anime, Model.Anime>();
            CreateMap<AnimeInsertRequest, Database.Anime>();
            CreateMap<AnimeUpdateRequest, Database.Anime>();


        }
    }
}

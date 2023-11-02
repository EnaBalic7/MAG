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

            CreateMap<Database.User, Model.User>();
            CreateMap<UserInsertRequest, Database.User>();
            CreateMap<UserUpdateRequest, Database.User>();

            CreateMap<Database.Role, Model.Role>();
            CreateMap<RoleInsertRequest, Database.Role>();
            CreateMap<RoleUpdateRequest, Database.Role>();

            CreateMap<Database.UserRole, Model.UserRole>();
            CreateMap<UserRoleInsertRequest, Database.UserRole>();
            CreateMap<UserRoleUpdateRequest, Database.UserRole>();

            CreateMap<Database.List, Model.List>();
            CreateMap<ListInsertRequest, Database.List>();
            CreateMap<ListUpdateRequest, Database.List>();

            CreateMap<Database.Genre, Model.Genre>();
            CreateMap<GenreInsertRequest, Database.Genre>();
            CreateMap<GenreUpdateRequest, Database.Genre>();
        }
    }
}

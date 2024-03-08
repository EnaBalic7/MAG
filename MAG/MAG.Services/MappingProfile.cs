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

            CreateMap<Database.Watchlist, Model.Watchlist>();
            CreateMap<WatchlistInsertRequest, Database.Watchlist>();
            CreateMap<WatchlistUpdateRequest, Database.Watchlist>();

            CreateMap<Database.Club, Model.Club>();
            CreateMap<ClubInsertRequest, Database.Club>();
            CreateMap<ClubUpdateRequest, Database.Club>();

            CreateMap<Database.ClubUser, Model.ClubUser>();
            CreateMap<ClubUserInsertRequest, Database.ClubUser>();
            // CreateMap<ClubUserUpdateRequest, Database.ClubUser>();

            CreateMap<Database.AnimeList, Model.AnimeList>();
            CreateMap<AnimeListInsertRequest, Database.AnimeList>();
            // CreateMap<AnimeListUpdateRequest, Database.AnimeList>();

            CreateMap<Database.Post, Model.Post>();
            CreateMap<PostInsertRequest, Database.Post>();
            CreateMap<PostUpdateRequest, Database.Post>();

            CreateMap<Database.Comment, Model.Comment>();
            CreateMap<CommentInsertRequest, Database.Comment>();
            CreateMap<CommentUpdateRequest, Database.Comment>();

            CreateMap<Database.GenreAnime, Model.GenreAnime>();
            CreateMap<GenreAnimeInsertRequest, Database.GenreAnime>();
            // CreateMap<GenreAnimeUpdateRequest, Database.GenreAnime>();

            CreateMap<Database.PreferredGenre, Model.PreferredGenre>();
            CreateMap<PreferredGenreInsertRequest, Database.PreferredGenre>();
            // CreateMap<PreferredGenreUpdateRequest, Database.PreferredGenre>();

            CreateMap<Database.QAcategory, Model.QAcategory>();
            CreateMap<QAcategoryInsertRequest, Database.QAcategory>();
            CreateMap<QAcategoryUpdateRequest, Database.QAcategory>();

            CreateMap<Database.QA, Model.QA>();
            CreateMap<QAInsertRequest, Database.QA>();
            CreateMap<QAUpdateRequest, Database.QA>();

            CreateMap<Database.Rating, Model.Rating>();
            CreateMap<RatingInsertRequest, Database.Rating>();
            CreateMap<RatingUpdateRequest, Database.Rating>();

            CreateMap<Database.Donation, Model.Donation>();
            CreateMap<DonationInsertRequest, Database.Donation>();
            CreateMap<DonationUpdateRequest, Database.Donation>();

            CreateMap<Database.UserProfilePicture, Model.UserProfilePicture>();
            CreateMap<UserProfilePictureInsertRequest, Database.UserProfilePicture>();
            CreateMap<UserProfilePictureUpdateRequest, Database.UserProfilePicture>();

            CreateMap<Database.ClubCover, Model.ClubCover>();
            CreateMap<ClubCoverInsertRequest, Database.ClubCover>();
            CreateMap<ClubCoverUpdateRequest, Database.ClubCover>();

            CreateMap<Database.AnimeWatchlist, Model.AnimeWatchlist>();
            CreateMap<AnimeWatchlistInsertRequest, Database.AnimeWatchlist>();
            CreateMap<AnimeWatchlistUpdateRequest, Database.AnimeWatchlist>();
        }
    }
}

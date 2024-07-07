using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Anime",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TitleEN = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    TitleJP = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Synopsis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    EpisodesNumber = table.Column<int>(type: "int", nullable: false),
                    ImageURL = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    TrailerURL = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Score = table.Column<decimal>(type: "decimal(4,2)", nullable: true),
                    BeginAir = table.Column<DateTime>(type: "datetime", nullable: false),
                    FinishAir = table.Column<DateTime>(type: "datetime", nullable: false),
                    Season = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false),
                    Studio = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Anime", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "ClubCover",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cover = table.Column<byte[]>(type: "varbinary(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClubCover", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Genre",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Genre", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Q&ACategory",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Q&ACategory", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Role",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Role", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "UserProfilePicture",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProfilePicture = table.Column<byte[]>(type: "varbinary(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserProfilePicture", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Genre_Anime",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GenreID = table.Column<int>(type: "int", nullable: false),
                    AnimeID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Genre_Anime", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Genre_Anime_Anime",
                        column: x => x.AnimeID,
                        principalTable: "Anime",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Genre_Anime_Genre",
                        column: x => x.GenreID,
                        principalTable: "Genre",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    PasswordSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    ProfilePictureID = table.Column<int>(type: "int", nullable: false),
                    DateJoined = table.Column<DateTime>(type: "datetime", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false, defaultValueSql: "('')", collation: "Latin1_General_CS_AS")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User", x => x.ID);
                    table.ForeignKey(
                        name: "FK_User_UserProfilePicture",
                        column: x => x.ProfilePictureID,
                        principalTable: "UserProfilePicture",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Club",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OwnerID = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MemberCount = table.Column<int>(type: "int", nullable: false),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: false),
                    CoverID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Club", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Club_ClubCover",
                        column: x => x.CoverID,
                        principalTable: "ClubCover",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Club_User",
                        column: x => x.OwnerID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Donation",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Amount = table.Column<double>(type: "float", nullable: false),
                    DateDonated = table.Column<DateTime>(type: "datetime", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Donation", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Donation_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "List",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DateCreated = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_List", x => x.ID);
                    table.ForeignKey(
                        name: "FK_List_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "PreferredGenres",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GenreID = table.Column<int>(type: "int", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PreferredGenres", x => x.ID);
                    table.ForeignKey(
                        name: "FK_PreferredGenres_Genre",
                        column: x => x.GenreID,
                        principalTable: "Genre",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_PreferredGenres_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Q&A",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    CategoryID = table.Column<int>(type: "int", nullable: false),
                    Question = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Answer = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Displayed = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Q&A", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Q&A_Q&ACategory",
                        column: x => x.CategoryID,
                        principalTable: "Q&ACategory",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Q&A_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Rating",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    AnimeID = table.Column<int>(type: "int", nullable: false),
                    RatingValue = table.Column<int>(type: "int", nullable: true),
                    ReviewText = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DateAdded = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rating", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Rating_Anime",
                        column: x => x.AnimeID,
                        principalTable: "Anime",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Rating_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "User_Role",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    RoleID = table.Column<int>(type: "int", nullable: false),
                    CanReview = table.Column<bool>(type: "bit", nullable: false),
                    CanAskQuestions = table.Column<bool>(type: "bit", nullable: false),
                    CanParticipateInClubs = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User_Role", x => x.ID);
                    table.ForeignKey(
                        name: "FK_User_Role_Role",
                        column: x => x.RoleID,
                        principalTable: "Role",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_User_Role_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Watchlist",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    DateAdded = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Watchlist", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Watchlist_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Club_User",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ClubID = table.Column<int>(type: "int", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Club_User", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Club_User_Club",
                        column: x => x.ClubID,
                        principalTable: "Club",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Club_User_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Post",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ClubID = table.Column<int>(type: "int", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LikesCount = table.Column<int>(type: "int", nullable: false),
                    DislikesCount = table.Column<int>(type: "int", nullable: false),
                    DatePosted = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Post", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Post_Club",
                        column: x => x.ClubID,
                        principalTable: "Club",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Post_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Anime_List",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ListID = table.Column<int>(type: "int", nullable: false),
                    AnimeID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Anime_List", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Anime_List_Anime",
                        column: x => x.AnimeID,
                        principalTable: "Anime",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Anime_List_List",
                        column: x => x.ListID,
                        principalTable: "List",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Anime_Watchlist",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AnimeID = table.Column<int>(type: "int", nullable: false),
                    WatchlistID = table.Column<int>(type: "int", nullable: false),
                    WatchStatus = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Progress = table.Column<int>(type: "int", nullable: false),
                    DateStarted = table.Column<DateTime>(type: "datetime", nullable: true),
                    DateFinished = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Anime_Watchlist", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Anime_Watchlist_Anime",
                        column: x => x.AnimeID,
                        principalTable: "Anime",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK_Anime_Watchlist_Watchlist",
                        column: x => x.WatchlistID,
                        principalTable: "Watchlist",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Comment",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PostID = table.Column<int>(type: "int", nullable: false),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LikesCount = table.Column<int>(type: "int", nullable: false),
                    DislikesCount = table.Column<int>(type: "int", nullable: false),
                    DateCommented = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comment", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Comment_Post",
                        column: x => x.PostID,
                        principalTable: "Post",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Comment_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "UserPostAction",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    PostID = table.Column<int>(type: "int", nullable: false),
                    Action = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserPostAction", x => x.ID);
                    table.ForeignKey(
                        name: "FK_UserPostAction_Post",
                        column: x => x.PostID,
                        principalTable: "Post",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserPostAction_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "UserCommentAction",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserID = table.Column<int>(type: "int", nullable: false),
                    CommentID = table.Column<int>(type: "int", nullable: false),
                    Action = table.Column<string>(type: "nvarchar(10)", maxLength: 10, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserCommentAction", x => x.ID);
                    table.ForeignKey(
                        name: "FK_UserCommentAction_Comment",
                        column: x => x.CommentID,
                        principalTable: "Comment",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserCommentAction_User",
                        column: x => x.UserID,
                        principalTable: "User",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Anime_List_AnimeID",
                table: "Anime_List",
                column: "AnimeID");

            migrationBuilder.CreateIndex(
                name: "IX_Anime_List_ListID",
                table: "Anime_List",
                column: "ListID");

            migrationBuilder.CreateIndex(
                name: "IX_Anime_Watchlist_AnimeID",
                table: "Anime_Watchlist",
                column: "AnimeID");

            migrationBuilder.CreateIndex(
                name: "IX_Anime_Watchlist_WatchlistID",
                table: "Anime_Watchlist",
                column: "WatchlistID");

            migrationBuilder.CreateIndex(
                name: "IX_Club_CoverID",
                table: "Club",
                column: "CoverID");

            migrationBuilder.CreateIndex(
                name: "IX_Club_OwnerID",
                table: "Club",
                column: "OwnerID");

            migrationBuilder.CreateIndex(
                name: "IX_Club_User_ClubID",
                table: "Club_User",
                column: "ClubID");

            migrationBuilder.CreateIndex(
                name: "IX_Club_User_UserID",
                table: "Club_User",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Comment_PostID",
                table: "Comment",
                column: "PostID");

            migrationBuilder.CreateIndex(
                name: "IX_Comment_UserID",
                table: "Comment",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Donation_UserID",
                table: "Donation",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Genre_Anime_AnimeID",
                table: "Genre_Anime",
                column: "AnimeID");

            migrationBuilder.CreateIndex(
                name: "IX_Genre_Anime_GenreID",
                table: "Genre_Anime",
                column: "GenreID");

            migrationBuilder.CreateIndex(
                name: "IX_List_UserID",
                table: "List",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Post_ClubID",
                table: "Post",
                column: "ClubID");

            migrationBuilder.CreateIndex(
                name: "IX_Post_UserID",
                table: "Post",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_PreferredGenres_GenreID",
                table: "PreferredGenres",
                column: "GenreID");

            migrationBuilder.CreateIndex(
                name: "IX_PreferredGenres_UserID",
                table: "PreferredGenres",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Q&A_CategoryID",
                table: "Q&A",
                column: "CategoryID");

            migrationBuilder.CreateIndex(
                name: "IX_Q&A_UserID",
                table: "Q&A",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Rating_AnimeID",
                table: "Rating",
                column: "AnimeID");

            migrationBuilder.CreateIndex(
                name: "IX_Rating_UserID",
                table: "Rating",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_User_ProfilePictureID",
                table: "User",
                column: "ProfilePictureID");

            migrationBuilder.CreateIndex(
                name: "IX_User_Role_RoleID",
                table: "User_Role",
                column: "RoleID");

            migrationBuilder.CreateIndex(
                name: "IX_User_Role_UserID",
                table: "User_Role",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_UserCommentAction_CommentID",
                table: "UserCommentAction",
                column: "CommentID");

            migrationBuilder.CreateIndex(
                name: "IX_UserCommentAction_UserID",
                table: "UserCommentAction",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_UserPostAction_PostID",
                table: "UserPostAction",
                column: "PostID");

            migrationBuilder.CreateIndex(
                name: "IX_UserPostAction_UserID",
                table: "UserPostAction",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Watchlist_UserID",
                table: "Watchlist",
                column: "UserID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Anime_List");

            migrationBuilder.DropTable(
                name: "Anime_Watchlist");

            migrationBuilder.DropTable(
                name: "Club_User");

            migrationBuilder.DropTable(
                name: "Donation");

            migrationBuilder.DropTable(
                name: "Genre_Anime");

            migrationBuilder.DropTable(
                name: "PreferredGenres");

            migrationBuilder.DropTable(
                name: "Q&A");

            migrationBuilder.DropTable(
                name: "Rating");

            migrationBuilder.DropTable(
                name: "User_Role");

            migrationBuilder.DropTable(
                name: "UserCommentAction");

            migrationBuilder.DropTable(
                name: "UserPostAction");

            migrationBuilder.DropTable(
                name: "List");

            migrationBuilder.DropTable(
                name: "Watchlist");

            migrationBuilder.DropTable(
                name: "Genre");

            migrationBuilder.DropTable(
                name: "Q&ACategory");

            migrationBuilder.DropTable(
                name: "Anime");

            migrationBuilder.DropTable(
                name: "Role");

            migrationBuilder.DropTable(
                name: "Comment");

            migrationBuilder.DropTable(
                name: "Post");

            migrationBuilder.DropTable(
                name: "Club");

            migrationBuilder.DropTable(
                name: "ClubCover");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "UserProfilePicture");
        }
    }
}

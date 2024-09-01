using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class Recommender : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Recommender",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AnimeID = table.Column<int>(type: "int", nullable: false),
                    CoAnimeID1 = table.Column<int>(type: "int", nullable: false),
                    CoAnimeID2 = table.Column<int>(type: "int", nullable: false),
                    CoAnimeID3 = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recommender", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Recommender_Anime",
                        column: x => x.AnimeID,
                        principalTable: "Anime",
                        principalColumn: "ID");
                });

            migrationBuilder.InsertData(
                table: "Anime_Watchlist",
                columns: new[] { "ID", "AnimeID", "DateFinished", "DateStarted", "Progress", "WatchStatus", "WatchlistID" },
                values: new object[,]
                {
                    { 6, 1, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Watching", 3 },
                    { 7, 7, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 3 },
                    { 8, 7, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 3 },
                    { 9, 7, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 4 },
                    { 10, 10, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 4 },
                    { 11, 3, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 4 },
                    { 12, 1, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 4 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Recommender_AnimeID",
                table: "Recommender",
                column: "AnimeID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Recommender");

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 12);
        }
    }
}

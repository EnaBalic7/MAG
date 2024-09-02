using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class DataForRecommender : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 2, new DateTime(2024, 7, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 4 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 4, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 6, new DateTime(2024, 7, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 5 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 9,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 8, new DateTime(2024, 7, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), 7 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 10,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 11, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 8 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 11,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 13, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 12,
                columns: new[] { "AnimeID", "DateStarted", "Progress", "WatchlistID" },
                values: new object[] { 9, new DateTime(2024, 7, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 5 });

            migrationBuilder.InsertData(
                table: "Anime_Watchlist",
                columns: new[] { "ID", "AnimeID", "DateFinished", "DateStarted", "Progress", "WatchStatus", "WatchlistID" },
                values: new object[,]
                {
                    { 13, 12, null, new DateTime(2024, 5, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, "Watching", 5 },
                    { 14, 14, null, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Watching", 5 },
                    { 15, 15, null, new DateTime(2024, 7, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, "Watching", 6 },
                    { 16, 17, null, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Watching", 6 },
                    { 17, 19, null, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 6, "Watching", 6 },
                    { 18, 16, null, new DateTime(2024, 7, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), 7, "Watching", 7 },
                    { 19, 18, null, new DateTime(2024, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, "Watching", 7 },
                    { 20, 20, null, new DateTime(2024, 7, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, "Watching", 7 },
                    { 21, 21, null, new DateTime(2024, 7, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, "Watching", 3 },
                    { 22, 22, null, new DateTime(2024, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, "Watching", 3 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 22);

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 6,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 7,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 7, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 8,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 7, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 9,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 7, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 10,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 10, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 11,
                columns: new[] { "AnimeID", "DateStarted", "Progress" },
                values: new object[] { 3, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 12,
                columns: new[] { "AnimeID", "DateStarted", "Progress", "WatchlistID" },
                values: new object[] { 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 4 });
        }
    }
}

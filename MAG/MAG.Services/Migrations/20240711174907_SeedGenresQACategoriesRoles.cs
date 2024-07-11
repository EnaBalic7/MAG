using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedGenresQACategoriesRoles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Genre",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { 1, "Action" },
                    { 2, "Drama" },
                    { 3, "Suspense" },
                    { 4, "Award Winning" },
                    { 5, "Sci-Fi" },
                    { 6, "Fantasy" },
                    { 7, "Mystery" },
                    { 8, "Adventure" },
                    { 9, "Horror" },
                    { 10, "Comedy" },
                    { 11, "Supernatural" },
                    { 12, "Romance" }
                });

            migrationBuilder.InsertData(
                table: "Q&ACategory",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { 1, "General" },
                    { 2, "App Support" },
                    { 3, "Feedback and Suggestions" },
                    { 4, "Feature Requests" }
                });

            migrationBuilder.InsertData(
                table: "Role",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { 1, "Administrator" },
                    { 2, "User" }
                });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 1,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 2,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 3,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 4,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 5,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 6,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 7,
                column: "DateJoined",
                value: new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.InsertData(
                table: "Genre_Anime",
                columns: new[] { "ID", "AnimeID", "GenreID" },
                values: new object[,]
                {
                    { 1, 9, 1 },
                    { 2, 9, 8 },
                    { 3, 9, 2 },
                    { 4, 9, 6 },
                    { 5, 8, 9 },
                    { 6, 8, 1 },
                    { 7, 8, 6 },
                    { 8, 7, 1 },
                    { 9, 7, 10 },
                    { 10, 7, 6 },
                    { 11, 6, 11 },
                    { 12, 6, 9 },
                    { 13, 6, 7 },
                    { 14, 5, 2 },
                    { 15, 5, 12 },
                    { 16, 4, 1 },
                    { 17, 4, 6 },
                    { 18, 4, 7 },
                    { 19, 3, 6 },
                    { 20, 3, 8 },
                    { 21, 3, 10 },
                    { 22, 2, 1 },
                    { 23, 2, 4 },
                    { 24, 2, 6 },
                    { 25, 10, 2 },
                    { 26, 10, 6 },
                    { 27, 1, 1 },
                    { 28, 1, 2 },
                    { 29, 1, 3 },
                    { 30, 11, 7 },
                    { 31, 11, 3 },
                    { 32, 12, 7 },
                    { 33, 12, 11 },
                    { 34, 12, 3 },
                    { 35, 13, 1 },
                    { 36, 13, 6 },
                    { 37, 13, 9 },
                    { 38, 13, 3 },
                    { 39, 14, 1 },
                    { 40, 15, 8 },
                    { 41, 15, 10 },
                    { 42, 15, 12 },
                    { 43, 15, 6 },
                    { 44, 17, 3 },
                    { 45, 17, 11 },
                    { 46, 20, 9 },
                    { 47, 20, 7 },
                    { 48, 20, 11 },
                    { 49, 21, 1 },
                    { 50, 21, 11 },
                    { 51, 22, 1 },
                    { 52, 22, 8 },
                    { 53, 22, 6 },
                    { 54, 22, 12 },
                    { 55, 16, 1 },
                    { 56, 16, 4 },
                    { 57, 16, 2 },
                    { 58, 16, 5 },
                    { 59, 18, 1 },
                    { 60, 18, 9 },
                    { 61, 18, 5 },
                    { 62, 19, 1 },
                    { 63, 19, 2 },
                    { 64, 19, 11 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 61);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 62);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 63);

            migrationBuilder.DeleteData(
                table: "Genre_Anime",
                keyColumn: "ID",
                keyValue: 64);

            migrationBuilder.DeleteData(
                table: "Q&ACategory",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Q&ACategory",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Q&ACategory",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Q&ACategory",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Genre",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 1,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3317));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 2,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3365));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 3,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3369));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 4,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3373));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 5,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3376));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 6,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3380));

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "ID",
                keyValue: 7,
                column: "DateJoined",
                value: new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3384));
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class PrefGenres : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Anime_List_Anime",
                table: "Anime_List");

            migrationBuilder.DropForeignKey(
                name: "FK_Anime_List_List",
                table: "Anime_List");

            migrationBuilder.DropForeignKey(
                name: "FK_Anime_Watchlist_Anime",
                table: "Anime_Watchlist");

            migrationBuilder.DropForeignKey(
                name: "FK_Donation_User",
                table: "Donation");

            migrationBuilder.DropForeignKey(
                name: "FK_Genre_Anime_Anime",
                table: "Genre_Anime");

            migrationBuilder.DropForeignKey(
                name: "FK_Genre_Anime_Genre",
                table: "Genre_Anime");

            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres");

            migrationBuilder.DropForeignKey(
                name: "FK_Rating_Anime",
                table: "Rating");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "Donation");

            migrationBuilder.AlterColumn<decimal>(
                name: "Amount",
                table: "Donation",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.AddColumn<string>(
                name: "TransactionID",
                table: "Donation",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "TrailerURL",
                table: "Anime",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ImageURL",
                table: "Anime",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Donation",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "Amount", "TransactionID" },
                values: new object[] { 20m, "txn_3PijFYRsmg17Kngz1idOozHb" });

            migrationBuilder.InsertData(
                table: "PreferredGenres",
                columns: new[] { "ID", "GenreID", "UserID" },
                values: new object[,]
                {
                    { 4, 12, 2 },
                    { 5, 7, 2 },
                    { 6, 12, 3 },
                    { 7, 11, 3 },
                    { 8, 11, 4 },
                    { 9, 6, 3 },
                    { 10, 6, 4 },
                    { 11, 6, 5 },
                    { 12, 1, 3 },
                    { 13, 1, 4 },
                    { 14, 1, 5 },
                    { 15, 1, 6 }
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_List_Anime",
                table: "Anime_List",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_List_List",
                table: "Anime_List",
                column: "ListID",
                principalTable: "List",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_Watchlist_Anime",
                table: "Anime_Watchlist",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Donation_User",
                table: "Donation",
                column: "UserID",
                principalTable: "User",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Genre_Anime_Anime",
                table: "Genre_Anime",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Genre_Anime_Genre",
                table: "Genre_Anime",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_Anime",
                table: "Rating",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Anime_List_Anime",
                table: "Anime_List");

            migrationBuilder.DropForeignKey(
                name: "FK_Anime_List_List",
                table: "Anime_List");

            migrationBuilder.DropForeignKey(
                name: "FK_Anime_Watchlist_Anime",
                table: "Anime_Watchlist");

            migrationBuilder.DropForeignKey(
                name: "FK_Donation_User",
                table: "Donation");

            migrationBuilder.DropForeignKey(
                name: "FK_Genre_Anime_Anime",
                table: "Genre_Anime");

            migrationBuilder.DropForeignKey(
                name: "FK_Genre_Anime_Genre",
                table: "Genre_Anime");

            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres");

            migrationBuilder.DropForeignKey(
                name: "FK_Rating_Anime",
                table: "Rating");

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DropColumn(
                name: "TransactionID",
                table: "Donation");

            migrationBuilder.AlterColumn<double>(
                name: "Amount",
                table: "Donation",
                type: "float",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AddColumn<string>(
                name: "Status",
                table: "Donation",
                type: "nvarchar(30)",
                maxLength: 30,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "TrailerURL",
                table: "Anime",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ImageURL",
                table: "Anime",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Donation",
                keyColumn: "ID",
                keyValue: 1,
                columns: new[] { "Amount", "Status" },
                values: new object[] { 20.0, "Completed" });

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_List_Anime",
                table: "Anime_List",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_List_List",
                table: "Anime_List",
                column: "ListID",
                principalTable: "List",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Anime_Watchlist_Anime",
                table: "Anime_Watchlist",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Donation_User",
                table: "Donation",
                column: "UserID",
                principalTable: "User",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Genre_Anime_Anime",
                table: "Genre_Anime",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Genre_Anime_Genre",
                table: "Genre_Anime",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_Rating_Anime",
                table: "Rating",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID");
        }
    }
}

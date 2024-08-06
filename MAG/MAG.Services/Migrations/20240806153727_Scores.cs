using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class Scores : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 1,
                column: "Score",
                value: 10m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 5,
                column: "Score",
                value: 1m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 7,
                column: "Score",
                value: 9m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 10,
                column: "Score",
                value: 8m);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 1,
                column: "Score",
                value: 0m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 5,
                column: "Score",
                value: 0m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 7,
                column: "Score",
                value: 0m);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 10,
                column: "Score",
                value: 0m);
        }
    }
}

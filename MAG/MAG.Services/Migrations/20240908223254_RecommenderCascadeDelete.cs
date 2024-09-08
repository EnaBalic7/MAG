using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class RecommenderCascadeDelete : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Recommender_Anime",
                table: "Recommender");

            migrationBuilder.AddForeignKey(
                name: "FK_Recommender_Anime",
                table: "Recommender",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Recommender_Anime",
                table: "Recommender");

            migrationBuilder.AddForeignKey(
                name: "FK_Recommender_Anime",
                table: "Recommender",
                column: "AnimeID",
                principalTable: "Anime",
                principalColumn: "ID");
        }
    }
}

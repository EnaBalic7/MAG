using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class prefGenresMistakeCorrection : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres");

            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenres_User",
                table: "PreferredGenres");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PreferredGenres",
                table: "PreferredGenres");

            migrationBuilder.RenameTable(
                name: "PreferredGenres",
                newName: "PreferredGenre");

            migrationBuilder.RenameIndex(
                name: "IX_PreferredGenres_UserID",
                table: "PreferredGenre",
                newName: "IX_PreferredGenre_UserID");

            migrationBuilder.RenameIndex(
                name: "IX_PreferredGenres_GenreID",
                table: "PreferredGenre",
                newName: "IX_PreferredGenre_GenreID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PreferredGenre",
                table: "PreferredGenre",
                column: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenre_Genre",
                table: "PreferredGenre",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenre_User",
                table: "PreferredGenre",
                column: "UserID",
                principalTable: "User",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenre_Genre",
                table: "PreferredGenre");

            migrationBuilder.DropForeignKey(
                name: "FK_PreferredGenre_User",
                table: "PreferredGenre");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PreferredGenre",
                table: "PreferredGenre");

            migrationBuilder.RenameTable(
                name: "PreferredGenre",
                newName: "PreferredGenres");

            migrationBuilder.RenameIndex(
                name: "IX_PreferredGenre_UserID",
                table: "PreferredGenres",
                newName: "IX_PreferredGenres_UserID");

            migrationBuilder.RenameIndex(
                name: "IX_PreferredGenre_GenreID",
                table: "PreferredGenres",
                newName: "IX_PreferredGenres_GenreID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PreferredGenres",
                table: "PreferredGenres",
                column: "ID");

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenres_Genre",
                table: "PreferredGenres",
                column: "GenreID",
                principalTable: "Genre",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PreferredGenres_User",
                table: "PreferredGenres",
                column: "UserID",
                principalTable: "User",
                principalColumn: "ID");
        }
    }
}

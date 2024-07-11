using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class test : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Anime",
                columns: new[] { "ID", "BeginAir", "EpisodesNumber", "FinishAir", "ImageURL", "Score", "Season", "Studio", "Synopsis", "TitleEN", "TitleJP", "TrailerURL" },
                values: new object[] { 1, new DateTime(2013, 4, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, new DateTime(2013, 9, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1907/134102l.jpg", null, "Spring", "Wit Studio", "Centuries ago, mankind was slaughtered to near extinction by monstrous humanoid creatures called Titans, forcing humans to hide in fear behind enormous concentric walls. What makes these giants truly terrifying is that their taste for human flesh is not born out of hunger but what appears to be out of pleasure. To ensure their survival, the remnants of humanity began living within defensive barriers, resulting in one hundred years without a single titan encounter. However, that fragile calm is soon shattered when a colossal Titan manages to breach the supposedly impregnable outer wall, reigniting the fight for survival against the man-eating abominations.\r\n\r\nAfter witnessing a horrific personal loss at the hands of the invading creatures, Eren Yeager dedicates his life to their eradication by enlisting into the Survey Corps, an elite military unit that combats the merciless humanoids outside the protection of the walls. Eren, his adopted sister Mikasa Ackerman, and his childhood friend Armin Arlert join the brutal war against the Titans and race to discover a way of defeating them before the last walls are breached.", "Attack on Titan", "Shingeki no Kyojin", "https://youtu.be/LHtdKWJdif4" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 1);
        }
    }
}

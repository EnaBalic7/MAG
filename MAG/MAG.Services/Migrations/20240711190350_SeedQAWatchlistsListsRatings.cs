using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedQAWatchlistsListsRatings : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "List",
                columns: new[] { "ID", "DateCreated", "Name", "UserID" },
                values: new object[] { 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), "Favorites", 2 });

            migrationBuilder.InsertData(
                table: "Q&A",
                columns: new[] { "ID", "Answer", "CategoryID", "Displayed", "Question", "UserID" },
                values: new object[,]
                {
                    { 1, "Certainly. A Constellation in our Universe is made out of Stars. Similarly, Constellation in My Anime Galaxy is made out of Stars that each represent a list of anime grouped together by a common theme/genre/feeling - whatever the user decides. You can make custom Stars to add to your Constellation and give each of them a name. This is great if you want to save some anime for certain occasions, for example you may save Tokyo Ghoul in a Star named \"Horror\" or \"Gore\" and watch it when you have a craving for something bloody.", 2, true, "Can you explain Constellations?", 2 },
                    { 2, "", 2, true, "How can I make my own watchlist?", 2 },
                    { 3, "Thank you, I worked very hard on it. Of course, the space theme is a must!", 3, true, "I really like the look and feel of this app. I suggest you stick with the space theme:)", 2 },
                    { 4, "It's in progress, it will be available once it's tested and ready.", 4, true, "Can we get a clubs feature in this app?", 5 },
                    { 5, "", 1, true, "How long did it take you to make this app?", 3 },
                    { 6, "You can try the official streaming services, such as Crunchyroll or Netflix.", 1, true, "Where can I watch these anime?", 4 },
                    { 7, "I had to choose something different, because professors were complaining about often-used app ideas.", 1, true, "What was the inspiration behind My Anime Galaxy?", 5 },
                    { 8, "", 1, true, "How do I create a star?", 5 },
                    { 9, "", 1, true, "How do I add Anime to my Nebula?", 4 },
                    { 10, "", 1, true, "Can I select a different language?", 3 },
                    { 11, "Light mode has not been developed and it is not planned in the near future.", 1, true, "Where can I turn on light mode?", 6 }
                });

            migrationBuilder.InsertData(
                table: "Rating",
                columns: new[] { "ID", "AnimeID", "DateAdded", "RatingValue", "ReviewText", "UserID" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 10, "Epic and intense, Attack on Titan captivates with its relentless action, intricate plot, and deep character development. The animation quality and soundtrack elevate it to a masterpiece of the genre.", 2 },
                    { 2, 7, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 9, "Despite initial comparisons, Black Clover evolves into a compelling shonen series with exciting battles and character development. Asta's journey is filled with determination and magic.", 2 },
                    { 3, 10, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 8, "Visually stunning and emotionally resonant, Violet Evergarden is a poetic exploration of love, loss, and self-discovery. The animation and music create a truly immersive experience", 2 },
                    { 4, 5, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "It is quite slow to be honest, not my cup of tea.", 2 }
                });

            migrationBuilder.InsertData(
                table: "User_Role",
                columns: new[] { "ID", "CanAskQuestions", "CanParticipateInClubs", "CanReview", "RoleID", "UserID" },
                values: new object[,]
                {
                    { 1, true, true, true, 1, 1 },
                    { 2, true, true, true, 2, 1 },
                    { 3, true, true, true, 2, 2 },
                    { 4, true, true, true, 2, 3 },
                    { 5, true, true, true, 2, 4 },
                    { 6, true, true, true, 2, 5 },
                    { 7, true, true, true, 2, 6 },
                    { 8, true, true, true, 2, 7 }
                });

            migrationBuilder.InsertData(
                table: "Watchlist",
                columns: new[] { "ID", "DateAdded", "UserID" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 1 },
                    { 2, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2 },
                    { 3, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 3 },
                    { 4, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 4 },
                    { 5, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 5 },
                    { 6, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 6 },
                    { 7, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 7 }
                });

            migrationBuilder.InsertData(
                table: "Anime_List",
                columns: new[] { "ID", "AnimeID", "ListID" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 7, 1 },
                    { 3, 10, 1 }
                });

            migrationBuilder.InsertData(
                table: "Anime_Watchlist",
                columns: new[] { "ID", "AnimeID", "DateFinished", "DateStarted", "Progress", "WatchStatus", "WatchlistID" },
                values: new object[,]
                {
                    { 1, 1, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 7, "Watching", 2 },
                    { 2, 7, new DateTime(2024, 4, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 170, "Completed", 2 },
                    { 3, 10, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, "On Hold", 2 },
                    { 4, 5, null, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Dropped", 2 },
                    { 5, 3, null, null, 0, "Plan to Watch", 2 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Anime_List",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Anime_List",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Anime_List",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Anime_Watchlist",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Q&A",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rating",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "User_Role",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "List",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Watchlist",
                keyColumn: "ID",
                keyValue: 2);
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class UserContentActionsSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "UserCommentAction",
                columns: new[] { "ID", "Action", "CommentID", "UserID" },
                values: new object[,]
                {
                    { 1, "like", 1, 2 },
                    { 2, "dislike", 2, 2 },
                    { 3, "like", 3, 2 },
                    { 4, "dislike", 4, 2 }
                });

            migrationBuilder.InsertData(
                table: "UserPostAction",
                columns: new[] { "ID", "Action", "PostID", "UserID" },
                values: new object[,]
                {
                    { 1, "like", 1, 2 },
                    { 2, "dislike", 2, 2 },
                    { 3, "like", 3, 2 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "UserCommentAction",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UserCommentAction",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "UserCommentAction",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "UserCommentAction",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "UserPostAction",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "UserPostAction",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "UserPostAction",
                keyColumn: "ID",
                keyValue: 3);
        }
    }
}

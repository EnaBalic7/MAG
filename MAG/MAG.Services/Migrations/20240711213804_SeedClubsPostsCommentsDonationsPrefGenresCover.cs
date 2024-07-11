using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedClubsPostsCommentsDonationsPrefGenresCover : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "ClubCover",
                columns: new[] { "ID", "Cover" },
                values: new object[] { 1, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 1, 0, 96, 0, 96, 0, 0, 255, 219, 0, 67, 0, 6, 4, 5, 6, 5, 4, 6, 6, 5, 6, 7, 7, 6, 8, 10, 16, 10, 10, 9, 9, 10, 20, 14, 15, 12, 16, 23, 20, 24, 24, 23, 20, 22, 22, 26, 29, 37, 31, 26, 27, 35, 28, 22, 22, 32, 44, 32, 35, 38, 39, 41, 42, 41, 25, 31, 45, 48, 45, 40, 48, 37, 40, 41, 40, 255, 219, 0, 67, 1, 7, 7, 7, 10, 8, 10, 19, 10, 10, 19, 40, 26, 22, 26, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 255, 192, 0, 17, 8, 0, 75, 0, 100, 3, 1, 34, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 31, 0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 196, 0, 181, 16, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 125, 1, 2, 3, 0, 4, 17, 5, 18, 33, 49, 65, 6, 19, 81, 97, 7, 34, 113, 20, 50, 129, 145, 161, 8, 35, 66, 177, 193, 21, 82, 209, 240, 36, 51, 98, 114, 130, 9, 10, 22, 23, 24, 25, 26, 37, 38, 39, 40, 41, 42, 52, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 255, 196, 0, 31, 1, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 196, 0, 181, 17, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 119, 0, 1, 2, 3, 17, 4, 5, 33, 49, 6, 18, 65, 81, 7, 97, 113, 19, 34, 50, 129, 8, 20, 66, 145, 161, 177, 193, 9, 35, 51, 82, 240, 21, 98, 114, 209, 10, 22, 36, 52, 225, 37, 241, 23, 24, 25, 26, 38, 39, 40, 41, 42, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 130, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 226, 227, 228, 229, 230, 231, 232, 233, 234, 242, 243, 244, 245, 246, 247, 248, 249, 250, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 240, 74, 42, 192, 179, 184, 41, 187, 202, 108, 126, 191, 149, 47, 216, 110, 51, 143, 44, 254, 98, 190, 140, 240, 110, 138, 212, 85, 175, 176, 220, 255, 0, 207, 63, 252, 120, 83, 147, 79, 184, 99, 130, 161, 125, 201, 255, 0, 10, 5, 116, 83, 162, 180, 227, 210, 250, 25, 100, 250, 133, 31, 214, 174, 67, 105, 12, 88, 218, 128, 159, 83, 201, 162, 194, 115, 70, 60, 118, 179, 200, 50, 145, 182, 58, 228, 241, 159, 206, 172, 166, 153, 33, 63, 60, 138, 7, 183, 53, 173, 69, 59, 19, 206, 204, 207, 236, 191, 250, 109, 255, 0, 142, 255, 0, 245, 234, 38, 211, 102, 25, 218, 200, 195, 183, 56, 38, 182, 222, 25, 35, 25, 146, 55, 81, 211, 37, 72, 166, 81, 97, 115, 51, 157, 154, 25, 33, 108, 72, 165, 127, 173, 71, 93, 53, 85, 150, 198, 9, 57, 218, 80, 250, 175, 20, 172, 82, 159, 115, 14, 138, 212, 58, 88, 201, 196, 164, 14, 217, 95, 254, 189, 20, 88, 174, 100, 105, 81, 86, 60, 181, 244, 253, 104, 242, 215, 211, 245, 163, 153, 28, 63, 89, 143, 98, 189, 21, 99, 203, 95, 79, 214, 156, 182, 229, 190, 236, 108, 126, 128, 154, 57, 131, 235, 80, 42, 210, 170, 179, 176, 84, 82, 204, 122, 0, 51, 90, 48, 233, 172, 255, 0, 124, 108, 30, 253, 127, 42, 210, 182, 181, 138, 217, 113, 24, 231, 187, 30, 166, 152, 150, 50, 151, 86, 80, 181, 210, 186, 53, 195, 127, 192, 23, 250, 154, 244, 239, 135, 95, 13, 110, 60, 71, 23, 218, 228, 111, 176, 105, 160, 237, 18, 4, 203, 75, 143, 238, 255, 0, 137, 253, 107, 140, 179, 139, 206, 186, 141, 14, 48, 79, 57, 244, 239, 95, 91, 232, 22, 209, 89, 232, 150, 16, 91, 168, 88, 214, 4, 192, 250, 128, 73, 252, 73, 205, 121, 153, 174, 46, 120, 106, 75, 147, 119, 248, 30, 166, 95, 74, 24, 150, 229, 123, 164, 121, 253, 207, 193, 157, 13, 237, 182, 219, 222, 223, 197, 62, 63, 214, 51, 43, 143, 251, 231, 3, 249, 215, 141, 248, 227, 193, 151, 30, 28, 212, 141, 174, 163, 26, 186, 184, 221, 21, 196, 99, 2, 65, 211, 63, 253, 99, 95, 89, 215, 158, 124, 111, 177, 138, 239, 194, 113, 200, 202, 12, 209, 78, 60, 179, 223, 144, 114, 63, 28, 15, 202, 188, 172, 187, 49, 175, 42, 202, 157, 71, 116, 206, 252, 94, 22, 159, 179, 115, 138, 179, 71, 203, 119, 122, 108, 145, 101, 162, 204, 139, 232, 7, 204, 42, 133, 117, 85, 82, 234, 194, 41, 206, 236, 108, 127, 80, 58, 253, 107, 234, 15, 157, 150, 46, 148, 116, 185, 129, 69, 104, 182, 155, 34, 158, 20, 55, 184, 106, 41, 92, 159, 174, 83, 54, 104, 162, 138, 227, 150, 62, 11, 163, 60, 80, 162, 138, 40, 250, 253, 62, 204, 2, 156, 172, 85, 129, 24, 207, 184, 205, 10, 172, 236, 21, 20, 179, 30, 128, 12, 213, 251, 93, 54, 71, 101, 105, 176, 169, 193, 199, 115, 237, 237, 80, 243, 8, 223, 72, 129, 62, 145, 230, 51, 51, 178, 32, 66, 48, 24, 32, 83, 250, 15, 243, 138, 247, 47, 135, 62, 49, 182, 159, 79, 131, 76, 212, 230, 88, 174, 161, 30, 92, 110, 231, 137, 20, 116, 231, 177, 29, 63, 10, 241, 245, 85, 69, 10, 138, 21, 71, 64, 6, 41, 107, 204, 197, 63, 173, 127, 16, 237, 193, 99, 170, 96, 231, 205, 13, 87, 99, 233, 139, 139, 251, 75, 104, 90, 107, 139, 168, 35, 137, 70, 75, 60, 128, 10, 241, 239, 137, 62, 44, 139, 93, 154, 43, 61, 63, 38, 202, 221, 139, 25, 14, 71, 152, 253, 50, 7, 160, 29, 62, 166, 184, 138, 43, 154, 134, 26, 52, 95, 54, 236, 238, 198, 103, 117, 49, 16, 246, 112, 143, 42, 127, 54, 96, 106, 16, 204, 146, 18, 227, 114, 142, 124, 192, 128, 103, 62, 184, 170, 117, 211, 93, 64, 183, 17, 20, 127, 168, 62, 135, 214, 177, 110, 52, 249, 226, 232, 165, 215, 56, 5, 70, 79, 229, 94, 204, 115, 6, 146, 78, 63, 215, 220, 120, 133, 58, 40, 162, 181, 88, 250, 118, 213, 48, 55, 124, 157, 53, 192, 33, 161, 32, 129, 140, 73, 215, 245, 169, 87, 79, 180, 101, 5, 99, 4, 30, 65, 12, 121, 253, 107, 155, 85, 79, 47, 106, 42, 249, 100, 116, 3, 130, 13, 56, 0, 9, 32, 96, 158, 79, 189, 76, 178, 245, 127, 118, 71, 68, 242, 105, 91, 221, 170, 238, 116, 95, 217, 214, 191, 243, 203, 255, 0, 30, 63, 227, 82, 37, 149, 178, 12, 8, 80, 247, 228, 103, 249, 215, 60, 183, 19, 47, 2, 105, 113, 233, 188, 213, 132, 212, 238, 149, 178, 92, 48, 244, 42, 63, 165, 101, 44, 190, 119, 247, 89, 203, 60, 163, 21, 21, 120, 206, 255, 0, 54, 111, 133, 3, 160, 3, 191, 20, 98, 176, 39, 214, 238, 163, 0, 165, 186, 73, 235, 183, 176, 252, 249, 170, 159, 219, 242, 124, 162, 73, 154, 54, 111, 225, 120, 241, 253, 42, 126, 161, 83, 186, 51, 142, 91, 141, 139, 189, 255, 0, 27, 157, 86, 40, 193, 174, 105, 174, 238, 25, 137, 51, 62, 125, 142, 41, 173, 113, 51, 2, 12, 178, 16, 120, 32, 177, 230, 180, 142, 94, 237, 172, 141, 86, 31, 16, 149, 159, 228, 255, 0, 204, 233, 169, 24, 133, 4, 146, 0, 28, 146, 123, 87, 45, 147, 140, 100, 227, 174, 41, 41, 255, 0, 103, 127, 123, 240, 255, 0, 130, 105, 42, 115, 138, 188, 149, 142, 155, 237, 48, 127, 207, 120, 191, 239, 161, 75, 246, 155, 127, 249, 239, 23, 253, 244, 43, 152, 162, 181, 250, 133, 62, 239, 250, 249, 24, 58, 109, 253, 167, 248, 127, 145, 209, 179, 89, 59, 22, 115, 110, 204, 122, 146, 65, 162, 185, 202, 40, 254, 207, 167, 221, 153, 253, 95, 251, 207, 239, 60, 218, 222, 234, 123, 102, 205, 188, 175, 25, 255, 0, 100, 226, 182, 45, 188, 79, 117, 24, 196, 241, 199, 55, 191, 221, 63, 225, 88, 20, 87, 97, 246, 77, 38, 118, 144, 120, 154, 201, 255, 0, 214, 137, 98, 62, 235, 145, 250, 85, 169, 53, 187, 48, 113, 28, 130, 70, 61, 48, 71, 39, 210, 184, 26, 40, 184, 185, 17, 219, 73, 169, 207, 35, 109, 133, 66, 100, 240, 0, 201, 169, 172, 236, 29, 220, 77, 118, 75, 119, 10, 199, 36, 253, 107, 131, 162, 139, 139, 144, 244, 215, 150, 52, 56, 121, 17, 79, 92, 22, 197, 65, 54, 161, 103, 14, 60, 219, 152, 148, 158, 219, 129, 53, 231, 52, 81, 112, 228, 59, 185, 181, 253, 62, 54, 192, 152, 185, 255, 0, 97, 73, 197, 103, 207, 226, 164, 218, 124, 139, 102, 39, 60, 23, 108, 113, 248, 87, 41, 69, 23, 31, 34, 55, 103, 241, 53, 235, 255, 0, 171, 17, 68, 61, 151, 39, 245, 170, 45, 172, 106, 13, 156, 221, 73, 207, 92, 28, 127, 42, 161, 69, 3, 178, 45, 127, 104, 222, 255, 0, 207, 229, 207, 253, 253, 111, 241, 162, 170, 209, 72, 118, 63, 255, 217 } });

            migrationBuilder.InsertData(
                table: "Donation",
                columns: new[] { "ID", "Amount", "DateDonated", "Status", "UserID" },
                values: new object[] { 1, 20.0, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), "Completed", 2 });

            migrationBuilder.InsertData(
                table: "PreferredGenres",
                columns: new[] { "ID", "GenreID", "UserID" },
                values: new object[,]
                {
                    { 1, 1, 2 },
                    { 2, 6, 2 },
                    { 3, 11, 2 }
                });

            migrationBuilder.InsertData(
                table: "Club",
                columns: new[] { "ID", "CoverID", "DateCreated", "Description", "MemberCount", "Name", "OwnerID" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), "This is a club for all lovers of Black Clover! We discuss events from both anime and manga :D", 0, "Black Clover Fans", 5 },
                    { 2, 1, new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), "Welcome and open to all well-mannered souls, for discussing all types of Anime and Manga :)", 0, "Happy Campers", 2 }
                });

            migrationBuilder.InsertData(
                table: "Club_User",
                columns: new[] { "ID", "ClubID", "UserID" },
                values: new object[,]
                {
                    { 1, 1, 2 },
                    { 2, 1, 5 },
                    { 3, 1, 1 },
                    { 4, 1, 3 },
                    { 5, 1, 4 },
                    { 6, 2, 2 }
                });

            migrationBuilder.InsertData(
                table: "Post",
                columns: new[] { "ID", "ClubID", "Content", "DatePosted", "DislikesCount", "LikesCount", "UserID" },
                values: new object[,]
                {
                    { 1, 1, "Do you think Captain Vangeance got away easy after he betrayed the Clover Kingdom? He barely even got a slap on the wrist!", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 6 },
                    { 2, 1, "I think William should have stayed the Golden Dawn captain. He's basically a GD icon, with his unique mask and abilities. Do you agree?", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 4 },
                    { 3, 1, "Who do you like better, Mimosa or Noelle?", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 3 },
                    { 4, 1, "Practicing my magic abilities takes time and effort. But gaining all those stars from the Wizard King sure is worth it!", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 5 }
                });

            migrationBuilder.InsertData(
                table: "Comment",
                columns: new[] { "ID", "Content", "DateCommented", "DislikesCount", "LikesCount", "PostID", "UserID" },
                values: new object[,]
                {
                    { 1, "I don't know, maybe. He seems like an empathetic person, so choosing either side would have been devastating. Maybe Julius thought he suffered enough.", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 1, 4 },
                    { 2, "I completely agree.", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 2, 5 },
                    { 3, "Yeah, and because of his incompetence I had to step in and become the captain of the Golden Dawn. I expected more backbone from a man in such a high position.", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 1, 7 },
                    { 4, "Agreed. That's why I work ten times as hard as anyone else. The one with most achievements is going to become the next Wizard King, and that's going to be me.", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 4, 7 },
                    { 5, "It's been my experience that hard work repays tenfold when you most need it.", new DateTime(2024, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 0, 0, 4, 6 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Club_User",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Comment",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Comment",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Comment",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Comment",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Comment",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Donation",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Post",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PreferredGenres",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Club",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Post",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Post",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Post",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Club",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "ClubCover",
                keyColumn: "ID",
                keyValue: 1);
        }
    }
}

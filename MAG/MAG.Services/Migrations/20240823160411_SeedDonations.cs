using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedDonations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Donation",
                columns: new[] { "ID", "Amount", "DateDonated", "TransactionID", "UserID" },
                values: new object[,]
                {
                    { 2, 3m, new DateTime(2024, 8, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), "txn_3PijFYRsmg17Kngz1idOozHc", 2 },
                    { 3, 8m, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), "txn_3PijFYRsmg17Kngz1idOozHd", 2 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Donation",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Donation",
                keyColumn: "ID",
                keyValue: 3);
        }
    }
}

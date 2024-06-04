using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class Donation
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public double Amount { get; set; }

    public DateTime DateDonated { get; set; }

    public string Status { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class ClubUser
{
    public int Id { get; set; }

    public int ClubId { get; set; }

    public int UserId { get; set; }

    public virtual Club Club { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}

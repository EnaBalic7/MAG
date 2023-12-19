using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class ClubCover
{
    public int Id { get; set; }

    public byte[] Cover { get; set; } = null!;

    public virtual ICollection<Club> Clubs { get; set; } = new List<Club>();
}

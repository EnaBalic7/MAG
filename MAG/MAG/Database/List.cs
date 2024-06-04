using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class List
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public string Name { get; set; } = null!;

    public DateTime DateCreated { get; set; }

    public virtual ICollection<AnimeList> AnimeLists { get; set; } = new List<AnimeList>();

    public virtual User User { get; set; } = null!;
}

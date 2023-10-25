using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class List
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public string Name { get; set; } = null!;

    public DateTime DateCreated { get; set; }

    public virtual User User { get; set; } = null!;

    public virtual ICollection<Anime> Animes { get; set; } = new List<Anime>();
}

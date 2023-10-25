using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class Genre
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Anime> Animes { get; set; } = new List<Anime>();

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}

using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class Watchlist
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public DateTime DateAdded { get; set; }

    public virtual ICollection<AnimeWatchlist> AnimeWatchlists { get; set; } = new List<AnimeWatchlist>();

    public virtual User User { get; set; } = null!;
}

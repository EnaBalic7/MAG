using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class AnimeWatchlist
{
    public int AnimeId { get; set; }

    public int WatchlistId { get; set; }

    public string WatchStatus { get; set; } = null!;

    public int Progress { get; set; }

    public virtual Anime Anime { get; set; } = null!;

    public virtual Watchlist Watchlist { get; set; } = null!;
}

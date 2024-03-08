using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class AnimeWatchlist
    {
        public int Id { get; set; }

        public int AnimeId { get; set; }

        public int WatchlistId { get; set; }

        public string WatchStatus { get; set; } = null!;

        public int Progress { get; set; }

        public DateTime? DateStarted { get; set; }

        public DateTime? DateFinished { get; set; }

        public virtual Anime Anime { get; set; } = null!;

        public virtual Watchlist Watchlist { get; set; } = null!;
    }
}

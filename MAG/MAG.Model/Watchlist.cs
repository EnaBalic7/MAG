using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class Watchlist
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public DateTime DateAdded { get; set; }

       // public virtual ICollection<AnimeWatchlist> AnimeWatchlists { get; set; } = new List<AnimeWatchlist>();

        public virtual User User { get; set; } = null!;
    }
}

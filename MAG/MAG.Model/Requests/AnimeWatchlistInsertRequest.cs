using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class AnimeWatchlistInsertRequest
    {
        public int AnimeId { get; set; }

        public int WatchlistId { get; set; }

        public string WatchStatus { get; set; } = null!;

        public int Progress { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class AnimeWatchlistSearchObject : BaseSearchObject
    {
        public string? WatchStatus { get; set; }

        public int? AnimeId { get; set; }

        public int? WatchlistId { get; set; }

        public bool? AnimeIncluded { get; set; }

        public bool? GenresIncluded { get; set; }

        public bool? NewestFirst { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class RatingSearchObject : BaseSearchObject
    {
        public int? Rating { get; set; }

        public string? FTS { get; set; }

        public int? UserId { get; set; }

        public int? AnimeId { get; set; }

        public bool? NewestFirst { get; set; }

        public int? TakeItems { get; set; }
    }
}

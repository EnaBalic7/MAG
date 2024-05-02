using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class AnimeListSearchObject : BaseSearchObject
    {
        public int? Id { get; set; }

        public int? AnimeId { get; set; }

        public int? ListId { get; set; }

        public bool? IncludeAnime { get; set; }

        public bool? GetRandom { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class AnimeSearchObject : BaseSearchObject
    {
        public string? Title { get; set; }
        public string? FTS { get; set; } //FTS - Full Text Search
        public bool? GenresIncluded { get; set; }
    }
}

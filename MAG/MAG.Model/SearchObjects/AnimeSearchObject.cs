using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class AnimeSearchObject : BaseSearchObject
    {
        public string? Name { get; set; }
        public string? FTS { get; set; } //FTS - Full Text Search
    }
}

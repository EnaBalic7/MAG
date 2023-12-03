using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class QASearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }
        public bool? UserIncluded { get; set; }
        public bool? CategoryIncluded { get; set; }
    }
}

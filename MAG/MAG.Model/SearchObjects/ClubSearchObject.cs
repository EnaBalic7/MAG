using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class ClubSearchObject : BaseSearchObject
    {
        public int? ClubId { get; set; }

        public int? OwnerId { get; set; }

        public string? Name { get; set; }

        public bool? CoverIncluded { get; set; }

        public bool? OrderByMemberCount { get; set; }
    }
}

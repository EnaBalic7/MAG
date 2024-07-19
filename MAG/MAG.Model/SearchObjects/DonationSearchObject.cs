using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class DonationSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }

        public bool? NewestFirst { get; set; }
    }
}

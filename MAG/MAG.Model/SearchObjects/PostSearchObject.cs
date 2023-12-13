using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class PostSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }

        public int? ClubId { get; set; }

        public int? UserId { get; set; } 
    }
}

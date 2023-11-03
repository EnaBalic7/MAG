using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class ClubInsertRequest
    {
        public int OwnerId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int MemberCount { get; set; }

        public DateTime DateCreated { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class ClubUserInsertRequest
    {
        public int ClubId { get; set; }

        public int UserId { get; set; }
    }
}

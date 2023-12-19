using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class ClubUpdateRequest
    {
        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int CoverId { get; set; }

    }
}

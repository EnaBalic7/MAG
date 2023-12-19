using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class ClubCover
    {
        public int Id { get; set; }

        public byte[] Cover { get; set; } = null!;

    }
}

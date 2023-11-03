using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class ClubUser
    {
        public int Id { get; set; }

        public int ClubId { get; set; }

        public int UserId { get; set; }

        public virtual Club Club { get; set; } = null!;

       // public virtual User User { get; set; } = null!;
    }
}

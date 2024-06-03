using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class Club
    {
        public int Id { get; set; }

        public int OwnerId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int MemberCount { get; set; }

        public DateTime DateCreated { get; set; }

        public int? CoverId { get; set; }

        public virtual ClubCover? Cover { get; set; }

        public virtual ICollection<ClubUser> ClubUsers { get; set; } = new List<ClubUser>();

        public virtual User Owner { get; set; } = null!;

        //public virtual ICollection<Post> Posts { get; set; } = new List<Post>();
    }
}

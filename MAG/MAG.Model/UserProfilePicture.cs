using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class UserProfilePicture
    {
        public int Id { get; set; }

        public byte[] ProfilePicture { get; set; } = null!;

        public virtual ICollection<User> Users { get; set; } = new List<User>();
    }
}

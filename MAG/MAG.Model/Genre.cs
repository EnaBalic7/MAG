using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class Genre
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public virtual ICollection<Anime> Animes { get; set; } = new List<Anime>();

        public virtual ICollection<User> Users { get; set; } = new List<User>();
    }
}

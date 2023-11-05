using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class GenreAnime
    {
        public int Id { get; set; }

        public int GenreId { get; set; }

        public int AnimeId { get; set; }

        public virtual Anime Anime { get; set; } = null!;

        public virtual Genre Genre { get; set; } = null!;
    }
}

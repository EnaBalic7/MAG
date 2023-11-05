using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class AnimeList
    {
        public int Id { get; set; }

        public int ListId { get; set; }

        public int AnimeId { get; set; }

        public virtual Anime Anime { get; set; } = null!;

        public virtual List List { get; set; } = null!;
    }
}

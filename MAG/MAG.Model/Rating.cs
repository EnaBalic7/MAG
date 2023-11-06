using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class Rating
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int AnimeId { get; set; }

        public int? RatingValue { get; set; }

        public string ReviewText { get; set; } = null!;

        public DateTime DateAdded { get; set; }

        public virtual Anime Anime { get; set; } = null!;

        public virtual User User { get; set; } = null!;
    }
}

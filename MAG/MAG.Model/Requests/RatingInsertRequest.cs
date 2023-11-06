using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class RatingInsertRequest
    {
        public int UserId { get; set; }

        public int AnimeId { get; set; }

        public int? RatingValue { get; set; }

        public string ReviewText { get; set; } = null!;

        public DateTime DateAdded { get; set; }
    }
}

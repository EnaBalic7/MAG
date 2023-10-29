using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class AnimeInsertRequest
    {
        public string TitleEn { get; set; } = null!;

        public string TitleJp { get; set; } = null!;

        public string Synopsis { get; set; } = null!;

        public int EpisodesNumber { get; set; }

        public string? ImageUrl { get; set; }

        public string? TrailerUrl { get; set; }

        public double Score { get; set; }

        public DateTime BeginAir { get; set; }

        public DateTime FinishAir { get; set; }

        public string Season { get; set; } = null!;

        public string Studio { get; set; } = null!;
    }
}

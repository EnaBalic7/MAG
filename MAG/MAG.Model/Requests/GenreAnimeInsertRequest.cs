using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.Requests
{
    public class GenreAnimeInsertRequest
    {
        public int GenreId { get; set; }

        public int AnimeId { get; set; }
    }
}

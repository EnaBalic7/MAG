using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML.Data;

namespace MAG.Model
{
    public class AnimeRecommendation
    {
        [KeyType(count: 27)]
        public uint AnimeId { get; set; }

        [KeyType(count: 27)]
        public uint CoAnimeId { get; set; }

        public float Label { get; set; }
    }
}

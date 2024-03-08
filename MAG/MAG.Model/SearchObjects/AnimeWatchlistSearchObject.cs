﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class AnimeWatchlistSearchObject : BaseSearchObject
    {
        public string? WatchStatus { get; set; }

        public int? WatchlistId { get; set; }
    }
}

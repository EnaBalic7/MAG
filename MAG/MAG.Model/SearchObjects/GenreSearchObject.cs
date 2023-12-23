﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class GenreSearchObject : BaseSearchObject
    {
        public string? Name { get; set; }

        public bool? SortAlphabetically { get; set; }
    }
}

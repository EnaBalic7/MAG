﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model.SearchObjects
{
    public class CommentSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }

        public int? PostId { get; set; }

        public int? UserId { get; set; }

        public bool? NewestFirst { get; set; }
    }
}

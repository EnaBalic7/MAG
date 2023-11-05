using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MAG.Model.Requests
{
    public class PostInsertRequest
    {
        public int ClubId { get; set; }

        public int UserId { get; set; }

        public string Content { get; set; } = null!;

        public int LikesCount { get; set; }

        public int DislikesCount { get; set; }

        public DateTime DatePosted { get; set; }
    }
}

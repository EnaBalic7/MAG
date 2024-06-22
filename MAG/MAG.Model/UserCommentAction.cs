using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Model
{
    public class UserCommentAction
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int CommentId { get; set; }

        public string Action { get; set; } = null!;
    }
}

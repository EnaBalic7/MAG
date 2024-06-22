using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class UserCommentAction
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int CommentId { get; set; }

    public string Action { get; set; } = null!;

    public virtual Comment Comment { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}

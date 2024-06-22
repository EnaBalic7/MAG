using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IUserCommentActionService : ICRUDService<Model.UserCommentAction, UserCommentActionSearchObject, UserCommentActionInsertRequest, UserCommentActionUpdateRequest>
    {
        Task<bool> CommentUserAction(int commentId, UserCommentActionInsertRequest userCommentAction, string username);
    }
}

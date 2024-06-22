using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class UserCommentActionController : BaseCRUDController<Model.UserCommentAction, UserCommentActionSearchObject, UserCommentActionInsertRequest, UserCommentActionUpdateRequest>
    {
        protected IUserCommentActionService _userCommentActionService;
        public UserCommentActionController(IUserCommentActionService service) : base(service)
        {
            _userCommentActionService = service;
        }

        [HttpPost("action/{commentId}")]
        public async Task<bool> CommentUserAction(int commentId, [FromBody] UserCommentActionInsertRequest userCommentAction)
        {
            var username = User.Identity!.Name;

           return await _userCommentActionService.CommentUserAction(commentId, userCommentAction, username!);
        }
    }
}
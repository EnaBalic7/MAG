using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class CommentController : BaseCRUDController<Model.Comment, CommentSearchObject, CommentInsertRequest, CommentUpdateRequest>
    {
        public CommentController(ICommentService service) : base(service)
        {

        }
    }
}
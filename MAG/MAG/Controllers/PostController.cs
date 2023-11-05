using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class PostController : BaseCRUDController<Model.Post, PostSearchObject, PostInsertRequest, PostUpdateRequest>
    {
        public PostController(IPostService service) : base(service)
        {

        }
    }
}
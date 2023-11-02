using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class ListController : BaseCRUDController<Model.List, ListSearchObject, ListInsertRequest, ListUpdateRequest>
    {
        public ListController(IListService service) : base(service)
        {

        }
    }
}
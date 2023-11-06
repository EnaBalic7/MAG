using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class RatingController : BaseCRUDController<Model.Rating, RatingSearchObject, RatingInsertRequest, RatingUpdateRequest>
    {
        public RatingController(IRatingService service) : base(service)
        {

        }
    }
}
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class UserProfilePictureController : BaseCRUDController<Model.UserProfilePicture, UserProfilePictureSearchObject, UserProfilePictureInsertRequest, UserProfilePictureUpdateRequest>
    {
        public UserProfilePictureController(IUserProfilePictureService service) : base(service)
        {

        }
    }
}
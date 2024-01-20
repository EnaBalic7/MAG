using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using MAG.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace MAG.Controllers
{
    [ApiController]
    public class UserController : BaseCRUDController<Model.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>
    {
        protected IUserService _userService;
        public UserController(IUserService service) : base(service)
        {
            _userService = service;
        }

        [AllowAnonymous]
        public override Task<Model.User> Insert([FromBody] UserInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [AllowAnonymous]
        public override Task<PagedResult<Model.User>> Get([FromQuery] UserSearchObject? search = null)
        {
            return base.Get(search);
        }

        [HttpGet("GetUserRegistrations/{days}")]
        public async Task<List<UserRegistrationData>> GetUserRegistrations(int days)
        {
            return await _userService.GetUserRegistrations(days);
        }

    }
}
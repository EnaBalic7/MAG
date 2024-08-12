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
        public async Task<List<UserRegistrationData>> GetUserRegistrations(int days, bool groupByMonths = false)
        {
            return await _userService.GetUserRegistrations(days, groupByMonths);
        }

        [HttpPost("ChangePassword/{userId}")]
        public async Task<IActionResult> ChangePassword(int userId, [FromBody] ChangePasswordRequest request)
        {
            try
            {
                if (userId != request.UserId)
                {
                    return Forbid("You don't have permission to change another user's password.");
                }

                await _userService.ChangePassword(request);

                return Ok(new { Message = "Password changed successfully." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

    }
}
using MAG.Model;
using MAG.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IService<T, TSearch> _service;
        public BaseController(IService<T, TSearch> service)
        {
            _service = service;
        }


        [HttpGet]
        public virtual async Task<PagedResult<T>> Get([FromQuery] TSearch? search = null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public virtual async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
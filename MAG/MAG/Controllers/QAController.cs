using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class QAController : BaseCRUDController<Model.QA, QASearchObject, QAInsertRequest, QAUpdateRequest>
    {
        public QAController(IQAService service) : base(service)
        {

        }
    }
}
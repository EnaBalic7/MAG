using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services;
using Microsoft.AspNetCore.Mvc;

namespace MAG.Controllers
{
    [ApiController]
    public class QAcategoryController : BaseCRUDController<Model.QAcategory, QAcategorySearchObject, QAcategoryInsertRequest, QAcategoryUpdateRequest>
    {
        public QAcategoryController(IQAcategoryService service) : base(service)
        {

        }
    }
}
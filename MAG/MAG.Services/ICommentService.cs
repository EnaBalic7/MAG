using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using Microsoft.EntityFrameworkCore.Scaffolding.Metadata;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface ICommentService : ICRUDService<Model.Comment, CommentSearchObject, CommentInsertRequest, CommentUpdateRequest>
    {
    }
}

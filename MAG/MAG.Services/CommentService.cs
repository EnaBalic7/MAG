using AutoMapper;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class CommentService : BaseCRUDService<Model.Comment, Database.Comment, CommentSearchObject, CommentInsertRequest, CommentUpdateRequest>, ICommentService
    {
        public CommentService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}

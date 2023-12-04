using AutoMapper;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class QAService : BaseCRUDService<Model.QA, Database.QA, QASearchObject, QAInsertRequest, QAUpdateRequest>, IQAService
    {
        public QAService(MagContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<QA> AddFilter(IQueryable<QA> query, QASearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => x.Question.Contains(search.FTS) || x.Answer.Contains(search.FTS));
            }

            if (search.NewestFirst == true)
            {
                query = query.OrderByDescending(x => x.Id);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<QA> AddInclude(IQueryable<QA> query, QASearchObject? search = null)
        {

            if (search.UserIncluded == true)
            {
                query = query.Include(x => x.User);
            }

            if (search.CategoryIncluded == true)
            {
                query = query.Include(x => x.Category);
            }

            return base.AddInclude(query, search);
        }
    }
}

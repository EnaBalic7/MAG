﻿using AutoMapper;
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


        public override IQueryable<Comment> AddFilter(IQueryable<Comment> query, CommentSearchObject? search = null)
        {
         
            if (search?.UserId != null)
            {
                query = query.Where(x => x.UserId == search.UserId);
            }

            if (search?.PostId != null)
            {
                query = query.Where(x => x.PostId == search.PostId);
            }

            if (search?.NewestFirst == true)
            {
                query = query.OrderByDescending(x => x.DateCommented);
            }

            if (search?.MostLikedFirst == true)
            {
                query = query.OrderByDescending(x => x.LikesCount);
            }

            return base.AddFilter(query, search);
        }

        public async Task<bool> DeleteAllCommentsByPostId(int postId)
        {
            var comments = _context.Comments.Where(x => x.PostId == postId).ToList();

            _context.RemoveRange(comments);

            await _context.SaveChangesAsync();

            return true;
        }


    }
}

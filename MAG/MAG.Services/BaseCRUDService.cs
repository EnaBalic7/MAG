﻿using AutoMapper;
using MAG.Model;
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
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate> where T : class where TDb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(MagContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();

            TDb entity = _mapper.Map<TDb>(insert);

            set.Add(entity);

            await BeforeInsert(entity, insert);

            await _context.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            if(entity != null) 
            {
                _mapper.Map(update, entity);
            }
            else
            {
                throw new UserException($"There is no entity in table [{set.GetType().ToString().Split('[', ']')[1]}] with provided ID [{id}]");
            }
            
            await _context.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }

        public virtual async Task BeforeDelete(TDb entity)
        {
        }

        public virtual async Task<T> Delete(int id)
        {
            var set = _context.Set<TDb>();

            var entity = await set.FindAsync(id);

            if(entity != null)
            {
                set.Remove(entity);
            }
            else
            {
                throw new UserException($"There is no entity in table [{set.GetType().ToString().Split('[', ']')[1]}] with provided ID [{id}]");
            }

            await BeforeDelete(entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<T>(entity);
        }
    }
}

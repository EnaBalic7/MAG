using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public interface IAnimeListService : ICRUDService<Model.AnimeList, AnimeListSearchObject, AnimeListInsertRequest, AnimeListUpdateRequest>
    {
        Task<bool> DeleteByAnimeId(int animeId);
        Task<bool> DeleteByListId(int listId);
        Task<bool> UpdateListsForAnime(int animeId, List<AnimeListInsertRequest> newLists);
    }
}

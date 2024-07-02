using AutoMapper;
using Azure.Core;
using MAG.Model;
using MAG.Model.Requests;
using MAG.Model.SearchObjects;
using MAG.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services
{
    public class UserService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {
        private readonly MagContext _context;

        private readonly IRabbitMQProducer _rabbitMQProducer;

        public UserService(MagContext context, IMapper mapper, IRabbitMQProducer rabbitMQProducer) : base(context, mapper)
        {
            _context = context;
            _rabbitMQProducer = rabbitMQProducer;
        }

        public override async Task AfterInsert(Database.User entity, UserInsertRequest insert)
        {
            if (insert.Email != null)
            {
                Model.Email email = new()
                {
                    Subject = "Welcoming email",
                    Content = "Welcome to MyAnimeGalaxy! We're thrilled to have you join our community of anime enthusiasts. At MyAnimeGalaxy, we believe that every anime fan deserves a place to discover, discuss, and share their passion. With our app, you can: explore a vast collection of anime shows and movies, track your watchlist and keep up with your favorite series, rate and review episodes and series, connect with other anime fans and join discussions, get recommendations tailored to your tastes. We hope you enjoy your journey through the galaxy of anime!",
                    Recipient = insert.Email,
                    Sender = "myanimegalaxy0@gmail.com",
                };
                _rabbitMQProducer.SendMessage(email);
            }
        }

        public override IQueryable<Database.User> AddInclude(IQueryable<Database.User> query, UserSearchObject? search = null)
        {
            if (search?.RolesIncluded == true)
            {
                query = query.Include(user => user.UserRoles)
                             .ThenInclude(userRole => userRole.Role);
            }

            if (search?.WatchlistsIncluded == true)
            {
                query = query.Include(watchlist => watchlist.Watchlists)
                            .ThenInclude(watchlists => watchlists.AnimeWatchlists);
            }

            if (search?.ProfilePictureIncluded == true)
            {
                query = query.Include(profilePicture => profilePicture.ProfilePicture);
            }


            return base.AddInclude(query, search);
        }
        public override async Task BeforeInsert(Database.User entity, UserInsertRequest insert)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, insert.Password);
        }

        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);

            return Convert.ToBase64String(byteArray);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public async Task<Model.User> Login(string username, string password)
        {

            var entity = await _context.Users.Include("UserRoles.Role").FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.PasswordSalt, password);

            if (hash != entity.PasswordHash)
            {
                return null;
            }

            return _mapper.Map<Model.User>(entity);
        }

        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query, UserSearchObject? search = null)
        {

            if (!string.IsNullOrWhiteSpace(search?.Username))
            {
                query = query.Where(x => x.Username == search.Username);
            }

            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                query = query.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                query = query.Where(x => x.LastName.StartsWith(search.LastName));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(x => (x.FirstName + " " + x.LastName).Contains(search.FTS) || (x.LastName + " " + x.FirstName).Contains(search.FTS) || x.Username.Contains(search.FTS));
            }

            if (search?.Id != null)
            {
                query = query.Where(x => x.Id == search.Id);
            }

                return base.AddFilter(query, search);
        }

        public async Task<List<UserRegistrationData>> GetUserRegistrations(int days, bool groupByMonths = false)
        {
            DateTime startDate = DateTime.Today.AddDays(-days);
            DateTime endDate = DateTime.Today;

            var userRegistrations = _context.Users
                .Where(user => user.DateJoined >= startDate)
                .ToList();

            var registrationsByDate = new Dictionary<DateTime, int>();

            if (groupByMonths == false)
            {
                for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
                {
                    int registrationsCount = userRegistrations
                        .Count(user => user.DateJoined.Date == date);

                    registrationsByDate[date] = registrationsCount;
                }
            }
            else if(groupByMonths == true)
            {
                for (DateTime date = startDate; date <= endDate; date = date.AddMonths(1))
                {
                    int registrationsCount = userRegistrations
                 .Count(user => user.DateJoined.Month == date.Month
                                && user.DateJoined.Year == date.Year);

                    registrationsByDate[date] = registrationsCount;
                }
            }

            var userRegistrationDataList = registrationsByDate
                .Select(pair => new UserRegistrationData
                {
                    DateJoined = pair.Key,
                    NumberOfUsers = pair.Value
                })
                .ToList();

            return userRegistrationDataList;
        }
    }
    
}

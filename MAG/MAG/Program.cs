using DotNetEnv;
using MAG;
using MAG.Filters;
using MAG.Services;
using MAG.Services.Database;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Stripe;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IAnimeService, AnimeService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<IRoleService, RoleService>();
builder.Services.AddTransient<IUserRoleService, UserRoleService>();
builder.Services.AddTransient<IListService, ListService>();
builder.Services.AddTransient<IGenreService, GenreService>();
builder.Services.AddTransient<IWatchlistService, WatchlistService>();
builder.Services.AddTransient<IClubService, ClubService>();
builder.Services.AddTransient<IClubUserService, ClubUserService>();
builder.Services.AddTransient<IAnimeListService, AnimeListService>();
builder.Services.AddTransient<IAnimeWatchlistService, AnimeWatchlistService>();
builder.Services.AddTransient<IPostService, PostService>();
builder.Services.AddTransient<ICommentService, CommentService>();
builder.Services.AddTransient<IGenreAnimeService, GenreAnimeService>();
builder.Services.AddTransient<IPreferredGenreService, PreferredGenreService>();
builder.Services.AddTransient<IQAcategoryService, QAcategoryService>();
builder.Services.AddTransient<IQAService, QAService>();
builder.Services.AddTransient<IRatingService, RatingService>();
builder.Services.AddTransient<IDonationService, DonationService>();
builder.Services.AddTransient<IUserProfilePictureService, UserProfilePictureService>();
builder.Services.AddTransient<IClubCoverService, ClubCoverService>();
builder.Services.AddTransient<IUserPostActionService, UserPostActionService>();
builder.Services.AddTransient<IUserCommentActionService, UserCommentActionService>();
builder.Services.AddScoped<IRabbitMQProducer, RabbitMQProducer>();



// Add services to the container.

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
            },
            new string[]{}

        }
    });
});


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<MagContext>(options => options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IAnimeService));

builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthentication();
app.UseAuthorization();

// Specify the URLs to listen on
app.Urls.Add("http://0.0.0.0:5262");
//app.Urls.Add("https://0.0.0.0:7074");

app.MapControllers();

// Keep commented when developing locally
using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<MagContext>();

   // if (!dataContext.Database.CanConnect())
   // {
        dataContext.Database.Migrate();
   // }
}

Env.Load("../.env");
string stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY") ?? "";
StripeConfiguration.ApiKey = stripeSecretKey;

app.Run();

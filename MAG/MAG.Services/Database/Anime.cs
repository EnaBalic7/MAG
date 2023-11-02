using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class Anime
{
    public int Id { get; set; }

    public string TitleEn { get; set; } = null!;

    public string TitleJp { get; set; } = null!;

    public string Synopsis { get; set; } = null!;

    public int EpisodesNumber { get; set; }

    public string? ImageUrl { get; set; }

    public string? TrailerUrl { get; set; }

    public double Score { get; set; }

    public DateTime BeginAir { get; set; }

    public DateTime FinishAir { get; set; }

    public string Season { get; set; } = null!;

    public string Studio { get; set; } = null!;

    public virtual ICollection<AnimeList> AnimeLists { get; set; } = new List<AnimeList>();

    public virtual ICollection<AnimeWatchlist> AnimeWatchlists { get; set; } = new List<AnimeWatchlist>();

    public virtual ICollection<GenreAnime> GenreAnimes { get; set; } = new List<GenreAnime>();

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();
}

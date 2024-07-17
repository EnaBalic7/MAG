using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class Recommender
{
    public int Id { get; set; }

    public int AnimeId { get; set; }

    public int CoAnimeId1 { get; set; }

    public int CoAnimeId2 { get; set; }

    public int CoAnimeId3 { get; set; }

    public virtual Anime Anime { get; set; } = null!;
}

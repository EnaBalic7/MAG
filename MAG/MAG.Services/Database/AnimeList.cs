using System;
using System.Collections.Generic;

namespace MAG.Services.Database;

public partial class AnimeList
{
    public int Id { get; set; }

    public int ListId { get; set; }

    public int AnimeId { get; set; }

    public virtual Anime Anime { get; set; } = null!;

    public virtual List List { get; set; } = null!;
}

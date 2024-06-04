using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class GenreAnime
{
    public int Id { get; set; }

    public int GenreId { get; set; }

    public int AnimeId { get; set; }

    public virtual Anime Anime { get; set; } = null!;

    public virtual Genre Genre { get; set; } = null!;
}

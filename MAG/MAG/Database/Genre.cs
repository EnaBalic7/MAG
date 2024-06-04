using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class Genre
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<GenreAnime> GenreAnimes { get; set; } = new List<GenreAnime>();

    public virtual ICollection<PreferredGenre> PreferredGenres { get; set; } = new List<PreferredGenre>();
}

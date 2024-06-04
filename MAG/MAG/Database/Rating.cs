using System;
using System.Collections.Generic;

namespace MAG.Database;

public partial class Rating
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int AnimeId { get; set; }

    public int? RatingValue { get; set; }

    public string ReviewText { get; set; } = null!;

    public DateTime DateAdded { get; set; }

    public virtual Anime Anime { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}

using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace MAG.Services.Database;

public partial class MyAnimeGalaxyContext : DbContext
{
    public MyAnimeGalaxyContext()
    {
    }

    public MyAnimeGalaxyContext(DbContextOptions<MyAnimeGalaxyContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Anime> Animes { get; set; }

    public virtual DbSet<AnimeWatchlist> AnimeWatchlists { get; set; }

    public virtual DbSet<Club> Clubs { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<Donation> Donations { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<List> Lists { get; set; }

    public virtual DbSet<Post> Posts { get; set; }

    public virtual DbSet<QA> QAs { get; set; }

    public virtual DbSet<QAcategory> QAcategories { get; set; }

    public virtual DbSet<Rating> Ratings { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserProfilePicture> UserProfilePictures { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }

    public virtual DbSet<Watchlist> Watchlists { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=MyAnimeGalaxy;TrustServerCertificate=true;Trusted_Connection=true");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Anime>(entity =>
        {
            entity.ToTable("Anime");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.BeginAir).HasColumnType("datetime");
            entity.Property(e => e.FinishAir).HasColumnType("datetime");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(200)
                .HasColumnName("ImageURL");
            entity.Property(e => e.Season).HasMaxLength(10);
            entity.Property(e => e.Studio).HasMaxLength(50);
            entity.Property(e => e.TitleEn)
                .HasMaxLength(200)
                .HasColumnName("TitleEN");
            entity.Property(e => e.TitleJp)
                .HasMaxLength(200)
                .HasColumnName("TitleJP");
            entity.Property(e => e.TrailerUrl)
                .HasMaxLength(200)
                .HasColumnName("TrailerURL");
        });

        modelBuilder.Entity<AnimeWatchlist>(entity =>
        {
            entity.HasKey(e => new { e.AnimeId, e.WatchlistId });

            entity.ToTable("Anime_Watchlist");

            entity.Property(e => e.AnimeId).HasColumnName("AnimeID");
            entity.Property(e => e.WatchlistId).HasColumnName("WatchlistID");
            entity.Property(e => e.WatchStatus).HasMaxLength(30);

            entity.HasOne(d => d.Anime).WithMany(p => p.AnimeWatchlists)
                .HasForeignKey(d => d.AnimeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Anime_Watchlist_Anime");

            entity.HasOne(d => d.Watchlist).WithMany(p => p.AnimeWatchlists)
                .HasForeignKey(d => d.WatchlistId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Anime_Watchlist_Watchlist");
        });

        modelBuilder.Entity<Club>(entity =>
        {
            entity.ToTable("Club");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateCreated).HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.OwnerId).HasColumnName("OwnerID");

            entity.HasOne(d => d.Owner).WithMany(p => p.Clubs)
                .HasForeignKey(d => d.OwnerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Club_User");

            entity.HasMany(d => d.Users).WithMany(p => p.ClubsNavigation)
                .UsingEntity<Dictionary<string, object>>(
                    "ClubUser",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Club_User_User"),
                    l => l.HasOne<Club>().WithMany()
                        .HasForeignKey("ClubId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Club_User_Club"),
                    j =>
                    {
                        j.HasKey("ClubId", "UserId");
                        j.ToTable("Club_User");
                        j.IndexerProperty<int>("ClubId").HasColumnName("ClubID");
                        j.IndexerProperty<int>("UserId").HasColumnName("UserID");
                    });
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.ToTable("Comment");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateCommented).HasColumnType("datetime");
            entity.Property(e => e.PostId).HasColumnName("PostID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Post).WithMany(p => p.Comments)
                .HasForeignKey(d => d.PostId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Comment_Post");

            entity.HasOne(d => d.User).WithMany(p => p.Comments)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Comment_User");
        });

        modelBuilder.Entity<Donation>(entity =>
        {
            entity.ToTable("Donation");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateDonated).HasColumnType("datetime");
            entity.Property(e => e.Status).HasMaxLength(20);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Donations)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Donation_User");
        });

        modelBuilder.Entity<Genre>(entity =>
        {
            entity.ToTable("Genre");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Name).HasMaxLength(50);

            entity.HasMany(d => d.Animes).WithMany(p => p.Genres)
                .UsingEntity<Dictionary<string, object>>(
                    "GenreAnime",
                    r => r.HasOne<Anime>().WithMany()
                        .HasForeignKey("AnimeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Genre_Anime_Anime"),
                    l => l.HasOne<Genre>().WithMany()
                        .HasForeignKey("GenreId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Genre_Anime_Genre"),
                    j =>
                    {
                        j.HasKey("GenreId", "AnimeId");
                        j.ToTable("Genre_Anime");
                        j.IndexerProperty<int>("GenreId").HasColumnName("GenreID");
                        j.IndexerProperty<int>("AnimeId").HasColumnName("AnimeID");
                    });

            entity.HasMany(d => d.Users).WithMany(p => p.Genres)
                .UsingEntity<Dictionary<string, object>>(
                    "PreferredGenre",
                    r => r.HasOne<User>().WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_PreferredGenres_User"),
                    l => l.HasOne<Genre>().WithMany()
                        .HasForeignKey("GenreId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_PreferredGenres_Genre"),
                    j =>
                    {
                        j.HasKey("GenreId", "UserId");
                        j.ToTable("PreferredGenres");
                        j.IndexerProperty<int>("GenreId").HasColumnName("GenreID");
                        j.IndexerProperty<int>("UserId").HasColumnName("UserID");
                    });
        });

        modelBuilder.Entity<List>(entity =>
        {
            entity.ToTable("List");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateCreated).HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(50);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Lists)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_List_User");

            entity.HasMany(d => d.Animes).WithMany(p => p.Lists)
                .UsingEntity<Dictionary<string, object>>(
                    "AnimeList",
                    r => r.HasOne<Anime>().WithMany()
                        .HasForeignKey("AnimeId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Anime_List_Anime"),
                    l => l.HasOne<List>().WithMany()
                        .HasForeignKey("ListId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK_Anime_List_List"),
                    j =>
                    {
                        j.HasKey("ListId", "AnimeId");
                        j.ToTable("Anime_List");
                        j.IndexerProperty<int>("ListId").HasColumnName("ListID");
                        j.IndexerProperty<int>("AnimeId").HasColumnName("AnimeID");
                    });
        });

        modelBuilder.Entity<Post>(entity =>
        {
            entity.ToTable("Post");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.ClubId).HasColumnName("ClubID");
            entity.Property(e => e.DatePosted).HasColumnType("datetime");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Club).WithMany(p => p.Posts)
                .HasForeignKey(d => d.ClubId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Post_Club");

            entity.HasOne(d => d.User).WithMany(p => p.Posts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Post_User");
        });

        modelBuilder.Entity<QA>(entity =>
        {
            entity.ToTable("Q&A");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.CategoryId).HasColumnName("CategoryID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Category).WithMany(p => p.QAs)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Q&A_Q&ACategory");

            entity.HasOne(d => d.User).WithMany(p => p.QAs)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Q&A_User");
        });

        modelBuilder.Entity<QAcategory>(entity =>
        {
            entity.ToTable("Q&ACategory");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<Rating>(entity =>
        {
            entity.ToTable("Rating");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.AnimeId).HasColumnName("AnimeID");
            entity.Property(e => e.DateAdded).HasColumnType("datetime");
            entity.Property(e => e.Rating1).HasColumnName("Rating");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Anime).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.AnimeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Rating_Anime");

            entity.HasOne(d => d.User).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Rating_User");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.ToTable("Role");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.Name).HasMaxLength(50);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("User");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateJoined).HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.FirstName).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(50);
            entity.Property(e => e.Password).HasMaxLength(50);
            entity.Property(e => e.PasswordHash).HasMaxLength(50);
            entity.Property(e => e.PasswordSalt).HasMaxLength(50);
            entity.Property(e => e.ProfilePictureId).HasColumnName("ProfilePictureID");
            entity.Property(e => e.Username).HasMaxLength(50);

            entity.HasOne(d => d.ProfilePicture).WithMany(p => p.Users)
                .HasForeignKey(d => d.ProfilePictureId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_UserProfilePicture");
        });

        modelBuilder.Entity<UserProfilePicture>(entity =>
        {
            entity.ToTable("UserProfilePicture");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
        });

        modelBuilder.Entity<UserRole>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.RoleId });

            entity.ToTable("User_Role");

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.RoleId).HasColumnName("RoleID");

            entity.HasOne(d => d.Role).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_Role_Role");

            entity.HasOne(d => d.User).WithMany(p => p.UserRoles)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_Role_User");
        });

        modelBuilder.Entity<Watchlist>(entity =>
        {
            entity.ToTable("Watchlist");

            entity.Property(e => e.Id)
                .ValueGeneratedNever()
                .HasColumnName("ID");
            entity.Property(e => e.DateAdded).HasColumnType("datetime");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.Watchlists)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Watchlist_User");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

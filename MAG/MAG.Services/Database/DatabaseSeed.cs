using MAG.Services.Helpers;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MAG.Services.Database
{
    public partial class MagContext
    {
        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedAnime(modelBuilder);
            SeedUserProfilePictures(modelBuilder);
            SeedClubCovers(modelBuilder);
            SeedUsers(modelBuilder);
            SeedQACategories(modelBuilder);
            SeedRoles(modelBuilder);
            SeedGenres(modelBuilder);
            SeedGenreAnime(modelBuilder);
            SeedUserRoles(modelBuilder);
            SeedQA(modelBuilder);
            SeedWatchlists(modelBuilder);
            SeedWatchlistAnime(modelBuilder);
            SeedLists(modelBuilder);
            SeedListAnime(modelBuilder);
            SeedRatings(modelBuilder);
            SeedPreferredGenres(modelBuilder);
            SeedDonations(modelBuilder);
            SeedClubs(modelBuilder);
            SeedClubUser(modelBuilder);
            SeedPosts(modelBuilder);
            SeedComments(modelBuilder);
        }

        private void SeedAnime(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Anime>().HasData(
                 new Anime()
                 {
                     Id = 1,
                     TitleEn = "Attack on Titan",
                     TitleJp = "Shingeki no Kyojin",
                     Synopsis = "Centuries ago, mankind was slaughtered to near extinction by monstrous humanoid creatures called Titans, forcing humans to hide in fear behind enormous concentric walls. What makes these giants truly terrifying is that their taste for human flesh is not born out of hunger but what appears to be out of pleasure. To ensure their survival, the remnants of humanity began living within defensive barriers, resulting in one hundred years without a single titan encounter. However, that fragile calm is soon shattered when a colossal Titan manages to breach the supposedly impregnable outer wall, reigniting the fight for survival against the man-eating abominations.\r\n\r\nAfter witnessing a horrific personal loss at the hands of the invading creatures, Eren Yeager dedicates his life to their eradication by enlisting into the Survey Corps, an elite military unit that combats the merciless humanoids outside the protection of the walls. Eren, his adopted sister Mikasa Ackerman, and his childhood friend Armin Arlert join the brutal war against the Titans and race to discover a way of defeating them before the last walls are breached.",
                     EpisodesNumber = 25,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1907/134102l.jpg",
                     TrailerUrl = "https://youtu.be/LHtdKWJdif4",
                     Score = 0,
                     BeginAir = new DateTime(2013, 4, 13),
                     FinishAir = new DateTime(2013, 9, 29),
                     Season = "Spring",
                     Studio = "Wit Studio"
                 },
                 new Anime()
                 {
                     Id = 2,
                     TitleEn = "Demon Slayer",
                     TitleJp = "Kimetsu no Yaiba",
                     Synopsis = "Ever since the death of his father, the burden of supporting the family has fallen upon Tanjirou Kamado's shoulders. Though living impoverished on a remote mountain, the Kamado family are able to enjoy a relatively peaceful and happy life. One day, Tanjirou decides to go down to the local village to make a little money selling charcoal. On his way back, night falls, forcing Tanjirou to take shelter in the house of a strange man, who warns him of the existence of flesh-eating demons that lurk in the woods at night.\r\n\r\nWhen he finally arrives back home the next day, he is met with a horrifying sight—his whole family has been slaughtered. Worse still, the sole survivor is his sister Nezuko, who has been turned into a bloodthirsty demon. Consumed by rage and hatred, Tanjirou swears to avenge his family and stay by his only remaining sibling. Alongside the mysterious group calling themselves the Demon Slayer Corps, Tanjirou will do whatever it takes to slay the demons and protect the remnants of his beloved sister's humanity.",
                     EpisodesNumber = 26,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1628/103229l.jpg",
                     TrailerUrl = "https://youtu.be/6vMuWuWlW4I",
                     Score = 0,
                     BeginAir = new DateTime(2019, 4, 6),
                     FinishAir = new DateTime(2019, 9, 28),
                     Season = "Spring",
                     Studio = "ufotable"
                 },
                 new Anime()
                 {
                     Id = 3,
                     TitleEn = "Little Witch Academia",
                     TitleJp = "Little Witch Academia",
                     Synopsis = "\"A believing heart is your magic!\"—these were the words that Atsuko \"Akko\" Kagari's idol, the renowned witch Shiny Chariot, said to her during a magic performance years ago. Since then, Akko has lived by these words and aspired to be a witch just like Shiny Chariot, one that can make people smile. Hence, even her non-magical background does not stop her from enrolling in Luna Nova Magical Academy.    However, when an excited Akko finally sets off to her new school, the trip there is anything but smooth. After her perilous journey, she befriends the shy Lotte Yansson and the sarcastic Sucy Manbavaran. To her utmost delight, she also discovers Chariot's wand, the Shiny Rod, which she takes as her own. Unfortunately, her time at Luna Nova will prove to be more challenging than Akko could ever believe. She absolutely refuses to stay inferior to the rest of her peers, especially to her self-proclaimed rival, the beautiful and gifted Diana Cavendish, so she relies on her determination to compensate for her reckless behavior and ineptitude in magic.    In a time when wizardry is on the decline, Little Witch Academia follows the magical escapades of Akko and her friends as they learn the true meaning of being a witch.",
                     EpisodesNumber = 25,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1884/120456l.jpg",
                     TrailerUrl = "https://youtu.be/S3jFdqs4jUQ",
                     Score = 0,
                     BeginAir = new DateTime(2017, 1, 9),
                     FinishAir = new DateTime(2017, 6, 26),
                     Season = "Winter",
                     Studio = "Trigger"
                 },
                 new Anime()
                 {
                     Id = 4,
                     TitleEn = "Black Butler",
                     TitleJp = "Kuroshitsuji",
                     Synopsis = "Young Ciel Phantomhive is known as \"the Queen's Guard Dog,\" taking care of the many unsettling events that occur in Victorian England for Her Majesty. Aided by Sebastian Michaelis, his loyal butler with seemingly inhuman abilities, Ciel uses whatever means necessary to get the job done. But is there more to this black-clad butler than meets the eye?    In Ciel's past lies a secret tragedy that enveloped him in perennial darkness—during one of his bleakest moments, he formed a contract with Sebastian, a demon, bargaining his soul in exchange for vengeance upon those who wronged him. Today, not only is Sebastian one hell of a butler, but he is also the perfect servant to carry out his master's orders—all the while anticipating the delicious meal he will eventually make of Ciel's soul. As the two work to unravel the mystery behind Ciel's chain of misfortunes, a bond forms between them that neither heaven nor hell can tear apart.",
                     EpisodesNumber = 24,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1467/137783l.jpg",
                     TrailerUrl = "https://youtu.be/S8j5iEklHyI",
                     Score = 0,
                     BeginAir = new DateTime(2008, 10, 3),
                     FinishAir = new DateTime(2009, 3, 27),
                     Season = "Fall",
                     Studio = "A-1 Pictures"
                 },
                 new Anime()
                 {
                     Id = 5,
                     TitleEn = "ReLIFE",
                     TitleJp = "ReLIFE",
                     Synopsis = "Dismissed as a hopeless loser by those around him, 27-year-old Arata Kaizaki bounces around from one job to another after quitting his first company. His unremarkable existence takes a sharp turn when he meets Ryou Yoake, a member of the ReLife Research Institute, who offers Arata the opportunity to change his life for the better with the help of a mysterious pill. Taking it without a second thought, Arata awakens the next day to find that his appearance has reverted to that of a 17-year-old.    Arata soon learns that he is now the subject of a unique experiment and must attend high school as a transfer student for one year. Though he initially believes it will be a cinch due to his superior life experience, Arata is proven horribly wrong on his first day: he flunks all his tests, is completely out of shape, and can't keep up with the new school policies that have cropped up in the last 10 years. Furthermore, Ryou has been assigned to observe him, bringing Arata endless annoyance. ReLIFE follows Arata's struggle to adjust to his hectic new lifestyle and avoid repeating his past mistakes, all while slowly discovering more about his fellow classmates.",
                     EpisodesNumber = 13,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/3/82149l.jpg",
                     TrailerUrl = "https://youtu.be/fZCgXuxMAZY",
                     Score = 0,
                     BeginAir = new DateTime(2016, 7, 2),
                     FinishAir = new DateTime(2016, 9, 24),
                     Season = "Summer",
                     Studio = "TMS Entertainment"
                 },
                 new Anime()
                 {
                     Id = 6,
                     TitleEn = "Another",
                     TitleJp = "Another",
                     Synopsis = "In class 3-3 of Yomiyama North Junior High, transfer student Kouichi Sakakibara makes his return after taking a sick leave for the first month of school. Among his new classmates, he is inexplicably drawn toward Mei Misaki—a reserved girl with an eyepatch whom he met in the hospital during his absence. But none of his classmates acknowledge her existence; they warn him not to acquaint himself with things that do not exist. Against their words of caution, Kouichi befriends Mei—soon learning of the sinister truth behind his friends' apprehension.    The ominous rumors revolve around a former student of the class 3-3. However, no one will share the full details of the grim event with Kouichi. Engrossed in the curse that plagues his class, Kouichi sets out to discover its connection to his new friend. As a series of tragedies arise around them, it is now up to Kouichi, Mei, and their classmates to unravel the eerie mystery—but doing so will come at a hefty price.",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/4/75509l.jpg",
                     TrailerUrl = "https://youtu.be/UGoAl3L13bc",
                     Score = 0,
                     BeginAir = new DateTime(2012, 1, 10),
                     FinishAir = new DateTime(2012, 3, 27),
                     Season = "Winter",
                     Studio = "P.A. Works"
                 },
                 new Anime()
                 {
                     Id = 7,
                     TitleEn = "Black Clover",
                     TitleJp = "Black Clover",
                     Synopsis = "Asta and Yuno were abandoned at the same church on the same day. Raised together as children, they came to know of the \"Wizard King\"—a title given to the strongest mage in the kingdom—and promised that they would compete against each other for the position of the next Wizard King. However, as they grew up, the stark difference between them became evident. While Yuno is able to wield magic with amazing power and control, Asta cannot use magic at all and desperately tries to awaken his powers by training physically.    When they reach the age of 15, Yuno is bestowed a spectacular Grimoire with a four-leaf clover, while Asta receives nothing. However, soon after, Yuno is attacked by a person named Lebuty, whose main purpose is to obtain Yuno's Grimoire. Asta tries to fight Lebuty, but he is outmatched. Though without hope and on the brink of defeat, he finds the strength to continue when he hears Yuno's voice. Unleashing his inner emotions in a rage, Asta receives a five-leaf clover Grimoire, a \"Black Clover\" giving him enough power to defeat Lebuty. A few days later, the two friends head out into the world, both seeking the same goal—to become the Wizard King!",
                     EpisodesNumber = 170,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1232/93334l.jpg",
                     TrailerUrl = "https://youtu.be/vUjAxk1qYzQ",
                     Score = 0,
                     BeginAir = new DateTime(2017, 10, 3),
                     FinishAir = new DateTime(2021, 3, 30),
                     Season = "Fall",
                     Studio = "Pierrot"
                 },
                 new Anime()
                 {
                     Id = 8,
                     TitleEn = "Tokyo Ghoul",
                     TitleJp = "Tokyo Ghoul",
                     Synopsis = "A sinister threat is invading Tokyo: flesh-eating \"ghouls\" who appear identical to humans and blend into their population. Reserved college student Ken Kaneki buries his nose in books and avoids the news of the growing crisis. However, the appearance of an attractive woman named Rize Kamishiro shatters his solitude when she forwardly asks him on a date.    While walking Rize home, Kaneki discovers she isn't as kind as she first appeared, and she has led him on with sinister intent. After a tragic struggle, he later awakens in a hospital to learn his life was saved by transplanting the now deceased Rize's organs into his own body.    Kaneki's body begins to change in horrifying ways, and he transforms into a human-ghoul hybrid. As he embarks on his new dreadful journey, Kaneki clings to his humanity in the evolving bloody conflict between society's new monsters and the government agents who hunt them.",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1498/134443l.jpg",
                     TrailerUrl = "https://youtu.be/vGuQeQsoRgU",
                     Score = 0,
                     BeginAir = new DateTime(2014, 7, 4),
                     FinishAir = new DateTime(2014, 9, 19),
                     Season = "Winter",
                     Studio = "Pierrot"
                 },
                 new Anime()
                 {
                     Id = 9,
                     TitleEn = "Fullmetal Alchemist: Brotherhood",
                     TitleJp = "Fullmetal Alchemist: Brotherhood",
                     Synopsis = "After a horrific alchemy experiment goes wrong in the Elric household, brothers Edward and Alphonse are left in a catastrophic new reality. Ignoring the alchemical principle banning human transmutation, the boys attempted to bring their recently deceased mother back to life. Instead, they suffered brutal personal loss: Alphonse's body disintegrated while Edward lost a leg and then sacrificed an arm to keep Alphonse's soul in the physical realm by binding it to a hulking suit of armor.    The brothers are rescued by their neighbor Pinako Rockbell and her granddaughter Winry. Known as a bio-mechanical engineering prodigy, Winry creates prosthetic limbs for Edward by utilizing \"automail,\" a tough, versatile metal used in robots and combat armor. After years of training, the Elric brothers set off on a quest to restore their bodies by locating the Philosopher's Stone—a powerful gem that allows an alchemist to defy the traditional laws of Equivalent Exchange.    As Edward becomes an infamous alchemist and gains the nickname \"Fullmetal,\" the boys' journey embroils them in a growing conspiracy that threatens the fate of the world.",
                     EpisodesNumber = 64,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1208/94745l.jpg",
                     TrailerUrl = "https://youtu.be/--IcmZkvL0Q",
                     Score = 0,
                     BeginAir = new DateTime(2009, 4, 5),
                     FinishAir = new DateTime(2010, 7, 4),
                     Season = "Spring",
                     Studio = "Bones"
                 },
                 new Anime()
                 {
                     Id = 10,
                     TitleEn = "Violet Evergarden",
                     TitleJp = "Violet Evergarden",
                     Synopsis = "The Great War finally came to an end after four long years of conflict; fractured in two, the continent of Telesis slowly began to flourish once again. Caught up in the bloodshed was Violet Evergarden, a young girl raised for the sole purpose of decimating enemy lines. Hospitalized and maimed in a bloody skirmish during the War's final leg, she was left with only words from the person she held dearest, but with no understanding of their meaning.    Recovering from her wounds, Violet starts a new life working at CH Postal Services after a falling out with her new intended guardian family. There, she witnesses by pure chance the work of an \"Auto Memory Doll,\" amanuenses that transcribe people's thoughts and feelings into words on paper. Moved by the notion, Violet begins work as an Auto Memory Doll, a trade that will take her on an adventure, one that will reshape the lives of her clients and hopefully lead to self-discovery.",
                     EpisodesNumber = 13,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1795/95088l.jpg",
                     TrailerUrl = "https://youtu.be/g5xWqjFglsk",
                     Score = 0,
                     BeginAir = new DateTime(2018, 1, 11),
                     FinishAir = new DateTime(2018, 4, 5),
                     Season = "Winter",
                     Studio = "Kyoto Animation"
                 },
                 new Anime()
                 {
                     Id = 11,
                     TitleEn = "Moriarty the Patriot",
                     TitleJp = "Yuukoku no Moriarty",
                     Synopsis = "During the late 19th century, Great Britain has become the greatest empire the world has ever known. Hidden within its success, the nation's rigid economic hierarchy dictates the value of one's life solely on status and wealth. To no surprise, the system favors the aristocracy at the top and renders it impossible for the working class to ascend the ranks.    William James Moriarty, the second son of the Moriarty household, lives as a regular noble while also being a consultant for the common folk to give them a hand and solve their problems. However, deep inside him lies a desire to destroy the current structure that dominates British society and those who benefit from it.    Alongside his brothers Albert and Louis, William will do anything it takes to change the filthy world he lives in—even if blood must be spilled.",
                     EpisodesNumber = 11,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1464/108330l.jpg",
                     TrailerUrl = "https://youtu.be/YA_zLUnLaQM",
                     Score = 0,
                     BeginAir = new DateTime(2020, 10, 11),
                     FinishAir = new DateTime(2020, 12, 20),
                     Season = "Fall",
                     Studio = "Production I.G"
                 },
                 new Anime()
                 {
                     Id = 12,
                     TitleEn = "ERASED",
                     TitleJp = "Boku dake ga Inai Machi",
                     Synopsis = "When tragedy is about to strike, Satoru Fujinuma finds himself sent back several minutes before the accident occurs. The detached, 29-year-old manga artist has taken advantage of this powerful yet mysterious phenomenon, which he calls \"Revival,\" to save many lives.    However, when he is wrongfully accused of murdering someone close to him, Satoru is sent back to the past once again, but this time to 1988, 18 years in the past. Soon, he realizes that the murder may be connected to the abduction and killing of one of his classmates, the solitary and mysterious Kayo Hinazuki, that took place when he was a child. This is his chance to make things right.    Boku dake ga Inai Machi follows Satoru in his mission to uncover what truly transpired 18 years ago and prevent the death of his classmate while protecting those he cares about in the present.",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/10/77957l.jpg",
                     TrailerUrl = "https://youtu.be/DwmxEAWjTQQ",
                     Score = 0,
                     BeginAir = new DateTime(2016, 1, 8),
                     FinishAir = new DateTime(2016, 3, 25),
                     Season = "Winter",
                     Studio = "A-1 Pictures"
                 },
                 new Anime()
                 {
                     Id = 13,
                     TitleEn = "Kabaneri of the Iron Fortress",
                     TitleJp = "Koutetsujou no Kabaneri",
                     Synopsis = "The world is in the midst of the industrial revolution when horrific creatures emerge from a mysterious virus, ripping through the flesh of humans to sate their never-ending appetite. The only way to kill these beings, known as \"Kabane,\" is by destroying their steel-coated hearts. However, if bitten by one of these monsters, the victim is doomed to a fate worse than death, as the fallen rise once more to join the ranks of their fellow undead.    Only the most fortified of civilizations have survived this turmoil, as is the case with the island of Hinomoto, where mankind has created a massive wall to protect themselves from the endless hordes of Kabane. The only way into these giant fortresses is via heavily-armored trains, which are serviced and built by young men such as Ikoma. Having created a deadly weapon that he believes will easily pierce through the hearts of Kabane, Ikoma eagerly awaits the day when he will be able to fight using his new invention. Little does he know, however, that his chance will come much sooner than he expected...",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/4/77657l.jpg",
                     TrailerUrl = "https://youtu.be/NljBw9RtOx4",
                     Score = 0,
                     BeginAir = new DateTime(2016, 4, 8),
                     FinishAir = new DateTime(2016, 7, 1),
                     Season = "Spring",
                     Studio = "Wit Studio"
                 },
                 new Anime()
                 {
                     Id = 14,
                     TitleEn = "My Hero Academia",
                     TitleJp = "Boku no Hero Academia ",
                     Synopsis = "The appearance of \"quirks,\" newly discovered super powers, has been steadily increasing over the years, with 80 percent of humanity possessing various abilities from manipulation of elements to shapeshifting. This leaves the remainder of the world completely powerless, and Izuku Midoriya is one such individual.    Since he was a child, the ambitious middle schooler has wanted nothing more than to be a hero. Izuku's unfair fate leaves him admiring heroes and taking notes on them whenever he can. But it seems that his persistence has borne some fruit: Izuku meets the number one hero and his personal idol, All Might. All Might's quirk is a unique ability that can be inherited, and he has chosen Izuku to be his successor!    Enduring many months of grueling training, Izuku enrolls in UA High, a prestigious high school famous for its excellent hero training program, and this year's freshmen look especially promising. With his bizarre but talented classmates and the looming threat of a villainous organization, Izuku will soon learn what it really means to be a hero.",
                     EpisodesNumber = 13,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1985/96688l.jpg",
                     TrailerUrl = "https://youtu.be/D5fYOnwYkj4",
                     Score = 0,
                     BeginAir = new DateTime(2016, 4, 3),
                     FinishAir = new DateTime(2016, 6, 26),
                     Season = "Spring",
                     Studio = "Bones"
                 },
                 new Anime()
                 {
                     Id = 15,
                     TitleEn = "Mermaid Melody: Pichi Pichi Pitch",
                     TitleJp = "Mermaid Melody: Pichi Pichi Pitch",
                     Synopsis = "As the mermaid princess of the North Pacific (one of the seven mermaid kingdoms), Lucia entrusts a magical pearl to a boy who falls overboard a ship one night. Lucia must travel to the human world to reclaim her pearl and protect the mermaid kingdoms. Using the power of music Lucia is able to protect herself and the mermaid kingdoms from a growing evil force.",
                     EpisodesNumber = 52,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/3/9640l.jpg",
                     TrailerUrl = "https://youtu.be/0jjxJ1gCCSg?si=coVddH065Hmf9axl",
                     Score = 0,
                     BeginAir = new DateTime(2003, 4, 5),
                     FinishAir = new DateTime(2004, 3, 27),
                     Season = "Spring",
                     Studio = "Actas"
                 },
                 new Anime()
                 {
                     Id = 16,
                     TitleEn = "Code Geass: Lelouch of the Rebellion",
                     TitleJp = "Code Geass: Hangyaku no Lelouch",
                     Synopsis = "In the year 2010, the Holy Empire of Britannia is establishing itself as a dominant military nation, starting with the conquest of Japan. Renamed to Area 11 after its swift defeat, Japan has seen significant resistance against these tyrants in an attempt to regain independence.    Lelouch Lamperouge, a Britannian student, unfortunately finds himself caught in a crossfire between the Britannian and the Area 11 rebel armed forces. He is able to escape, however, thanks to the timely appearance of a mysterious girl named C.C., who bestows upon him Geass, the \"Power of Kings.\" Realizing the vast potential of his newfound \"power of absolute obedience,\" Lelouch embarks upon a perilous journey as the masked vigilante known as Zero, leading a merciless onslaught against Britannia in order to get revenge once and for all.",
                     EpisodesNumber = 25,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1073/91139l.jpg",
                     TrailerUrl = "https://youtu.be/ulQGo6X7kFo?si=SJcQZudCN13ob47U",
                     Score = 0,
                     BeginAir = new DateTime(2006, 10, 6),
                     FinishAir = new DateTime(2007, 7, 29),
                     Season = "Fall",
                     Studio = "Sunrise"
                 },
                 new Anime()
                 {
                     Id = 17,
                     TitleEn = "Death Note",
                     TitleJp = "Death Note",
                     Synopsis = "Brutal murders, petty thefts, and senseless violence pollute the human world. In contrast, the realm of death gods is a humdrum, unchanging gambling den. The ingenious 17-year-old Japanese student Light Yagami and sadistic god of death Ryuk share one belief: their worlds are rotten.    For his own amusement, Ryuk drops his Death Note into the human world. Light stumbles upon it, deeming the first of its rules ridiculous: the human whose name is written in this note shall die. However, the temptation is too great, and Light experiments by writing a felon's name, which disturbingly enacts his first murder.    Aware of the terrifying godlike power that has fallen into his hands, Light—under the alias Kira—follows his wicked sense of justice with the ultimate goal of cleansing the world of all evil-doers. The meticulous mastermind detective L is already on his trail, but as Light's brilliance rivals L's, the grand chase for Kira turns into an intense battle of wits that can only end when one of them is dead.",
                     EpisodesNumber = 37,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1079/138100l.jpg",
                     TrailerUrl = "https://youtu.be/tJZtOrm-WPk?si=lFWxefLVUyPY8O3-",
                     Score = 0,
                     BeginAir = new DateTime(2006, 10, 4),
                     FinishAir = new DateTime(2007, 6, 27),
                     Season = "Fall",
                     Studio = "Madhouse"
                 },
                 new Anime()
                 {
                     Id = 18,
                     TitleEn = "Parasyte: The Maxim",
                     TitleJp = "Kiseijuu: Sei no Kakuritsu",
                     Synopsis = "All of a sudden, they arrived: parasitic aliens that descended upon Earth and quickly infiltrated humanity by burrowing into the brains of vulnerable targets. These insatiable beings acquire full control of their host and are able to morph into a variety of forms in order to feed on unsuspecting prey.    Sixteen-year-old high school student Shinichi Izumi falls victim to one of these parasites, but it fails to take over his brain, ending up in his right hand instead. Unable to relocate, the parasite, now named Migi, has no choice but to rely on Shinichi in order to stay alive. Thus, the pair is forced into an uneasy coexistence and must defend themselves from hostile parasites that hope to eradicate this new threat to their species.",
                     EpisodesNumber = 24,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/3/73178l.jpg",
                     TrailerUrl = "https://youtu.be/9Oe9umzw1Gc",
                     Score = 0,
                     BeginAir = new DateTime(2014, 10, 9),
                     FinishAir = new DateTime(2015, 3, 26),
                     Season = "Fall",
                     Studio = "Madhouse"
                 },
                 new Anime()
                 {
                     Id = 19,
                     TitleEn = "Seraph of the End: Vampire Reign",
                     TitleJp = "Owari no Seraph",
                     Synopsis = "With the appearance of a mysterious virus that kills everyone above the age of 13, mankind becomes enslaved by previously hidden, power-hungry vampires who emerge in order to subjugate society with the promise of protecting the survivors, in exchange for donations of their blood.    Among these survivors are Yuuichirou and Mikaela Hyakuya, two young boys who are taken captive from an orphanage, along with other children whom they consider family. Discontent with being treated like livestock under the vampires' cruel reign, Mikaela hatches a rebellious escape plan that is ultimately doomed to fail. The only survivor to come out on the other side is Yuuichirou, who is found by the Moon Demon Company, a military unit dedicated to exterminating the vampires in Japan.    Many years later, now a member of the Japanese Imperial Demon Army, Yuuichirou is determined to take revenge on the creatures that slaughtered his family, but at what cost?    Owari no Seraph is a post-apocalyptic supernatural shounen anime that follows a young man's search for retribution, all the while battling for friendship and loyalty against seemingly impossible odds.",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/5/73474l.jpg",
                     TrailerUrl = "https://youtu.be/NtzDAmRhD9s",
                     Score = 0,
                     BeginAir = new DateTime(2015, 4, 4),
                     FinishAir = new DateTime(2015, 6, 20),
                     Season = "Spring",
                     Studio = "Wit Studio"
                 },
                 new Anime()
                 {
                     Id = 20,
                     TitleEn = "Shiki",
                     TitleJp = "Shiki",
                     Synopsis = "Life is idyllic and unassuming in the small town of Sotoba, a simple place where everyone knows everyone. However, tragedy strikes when Megumi Shimizu, a young girl with high aspirations, unexpectedly passes away from an unnamed illness. Over the torrid summer months, as more unexplained deaths crop up around the village, the town's doctor—Toshio Ozaki—begins to suspect that something more sinister than a mere disease is at play.    Toshio teams up with Natsuno Yuuki, an apathetic and aloof teenager, and siblings Kaori and Akira Tanaka, two of Megumi's friends, to unravel the dark mystery behind the deaths in Sotoba. With their combined efforts, the investigation leads them toward an eerie secret pertaining to the new family in the Kanemasa mansion.",
                     EpisodesNumber = 22,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1531/119165l.jpg",
                     TrailerUrl = "https://youtu.be/W6yEzWAd_vg?si=zZVV44m_vzstFp-U",
                     Score = 0,
                     BeginAir = new DateTime(2010, 7, 9),
                     FinishAir = new DateTime(2010, 12, 31),
                     Season = "Summer",
                     Studio = "Daume"
                 },
                 new Anime()
                 {
                     Id = 21,
                     TitleEn = "Sirius the Jaeger",
                     TitleJp = "Sirius",
                     Synopsis = "In the year 1930, vampires have infiltrated Tokyo to feast upon its unsuspecting citizens. As the number of victims continues to rise, the city's authorities decide to hire the Jaegers—a strange, diverse group of individuals tasked by the V Shipping Company to hunt down vampires around the world. Carrying musical instrument cases to disguise their identity, the Jaegers battle the vampires with the same mercilessness demonstrated by their foes.    Yuliy, the Jaeger's most skilled warrior, is the sole survivor of a vampire raid on his home village. Using the strength granted by his werewolf blood, he works with his team to assist Tokyo's law enforcement with the city's vampire problem. Though under the pretense of helping the police, the Jaegers are actually fighting the vampires over the mystical Ark of Sirius. With its power to change the fate of the world, Yuliy and his friends must locate the artifact before the vampires can use it to achieve their destructive goals.",
                     EpisodesNumber = 12,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/1226/94893l.jpg",
                     TrailerUrl = "https://youtu.be/K1zgQyxJDio",
                     Score = 0,
                     BeginAir = new DateTime(2018, 7, 12),
                     FinishAir = new DateTime(2018, 9, 27),
                     Season = "Summer",
                     Studio = "P.A. Works"
                 },
                 new Anime()
                 {
                     Id = 22,
                     TitleEn = "Sword Art Online",
                     TitleJp = "Sword Art Online",
                     Synopsis = "Ever since the release of the innovative NerveGear, gamers from all around the globe have been given the opportunity to experience a completely immersive virtual reality. Sword Art Online (SAO), one of the most recent games on the console, offers a gateway into the wondrous world of Aincrad, a vivid, medieval landscape where users can do anything within the limits of imagination. With the release of this worldwide sensation, gaming has never felt more lifelike.    However, the idyllic fantasy rapidly becomes a brutal nightmare when SAO's creator traps thousands of players inside the game. The \"log-out\" function has been removed, with the only method of escape involving beating all of Aincrad's one hundred increasingly difficult levels. Adding to the struggle, any in-game death becomes permanent, ending the player's life in the real world.    While Kazuto \"Kirito\" Kirigaya was fortunate enough to be a beta-tester for the game, he quickly finds that despite his advantages, he cannot overcome SAO's challenges alone. Teaming up with Asuna Yuuki and other talented players, Kirito makes an effort to face the seemingly insurmountable trials head-on. But with difficult bosses and threatening dark cults impeding his progress, Kirito finds that such tasks are much easier said than done.",
                     EpisodesNumber = 25,
                     ImageUrl = "https://cdn.myanimelist.net/images/anime/8/36343l.jpg",
                     TrailerUrl = "https://youtu.be/6ohYYtxfDCg",
                     Score = 0,
                     BeginAir = new DateTime(2012, 7, 8),
                     FinishAir = new DateTime(2012, 12, 23),
                     Season = "Summer",
                     Studio = "A-1 Pictures"
                 }
            );
        }

        private void SeedUserProfilePictures(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserProfilePicture>().HasData(
                new UserProfilePicture()
                {
                    Id = 1,
                    ProfilePicture = ImageHelper.ConvertImageToByteArray("SeedImages/blank_profile_pic.jpg")
                }
         );
        }

        private void SeedClubCovers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ClubCover>().HasData(
                new ClubCover()
                {
                    Id = 1,
                    Cover = ImageHelper.ConvertImageToByteArray("SeedImages/cover.jpg")
                }
         );
        }

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            string hash = "my/ELwTcrvtQ7tlVYibJNnISjtw=";
            string salt = "u9Rht8UH9bvKrDQnbeNh7A==";

            modelBuilder.Entity<User>().HasData(
                new User()
                {
                    Id = 1,
                    FirstName = "Ena",
                    LastName = "Balić",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = "ena.balic@edu.fit.ba",
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Administrator",
                },
                new User()
                {
                    Id = 2,
                    FirstName = "Mikaela",
                    LastName = "Hyakuya",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Mika",
                },
                new User()
                {
                    Id = 3,
                    FirstName = "Muzan",
                    LastName = "Kibutsuji",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Master-Muzan",
                },
                new User()
                {
                    Id = 4,
                    FirstName = "Julius",
                    LastName = "Novachrono",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Chronovala",
                },
                new User()
                {
                    Id = 5,
                    FirstName = "Vanessa",
                    LastName = "Enoteca",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "ThreadOfFate",
                },
                new User()
                {
                    Id = 6,
                    FirstName = "William",
                    LastName = "Vangeance",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Captain-William",
                },
                new User()
                {
                    Id = 7,
                    FirstName = "Yuno",
                    LastName = "Grinberryall",
                    PasswordHash = hash,
                    PasswordSalt = salt,
                    Email = null,
                    ProfilePictureId = 1,
                    DateJoined = new DateTime(2024, 7, 11),
                    Username = "Yuno",
                }
         );
        }

        private void SeedQACategories(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<QAcategory>().HasData(
                new QAcategory()
                {
                    Id = 1,
                    Name = "General"
                },
                new QAcategory()
                {
                    Id = 2,
                    Name = "App Support"
                },
                new QAcategory()
                {
                    Id = 3,
                    Name = "Feedback and Suggestions"
                },
                new QAcategory()
                {
                    Id = 4,
                    Name = "Feature Requests"
                }
         );
        }

        private void SeedRoles(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Role>().HasData(
                new Role()
                {
                    Id = 1,
                    Name = "Administrator"
                },
                new Role()
                {
                    Id = 2,
                    Name = "User"
                }
         );
        }

        private void SeedGenres(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Genre>().HasData(
                new Genre()
                {
                    Id = 1,
                    Name = "Action"
                },
                new Genre()
                {
                    Id = 2,
                    Name = "Drama"
                },
                new Genre()
                {
                    Id = 3,
                    Name = "Suspense"
                },
                new Genre()
                {
                    Id = 4,
                    Name = "Award Winning"
                },
                new Genre()
                {
                    Id = 5,
                    Name = "Sci-Fi"
                },
                new Genre()
                {
                    Id = 6,
                    Name = "Fantasy"
                },
                new Genre()
                {
                    Id = 7,
                    Name = "Mystery"
                },
                new Genre()
                {
                    Id = 8,
                    Name = "Adventure"
                },
                new Genre()
                {
                    Id = 9,
                    Name = "Horror"
                },
                new Genre()
                {
                    Id = 10,
                    Name = "Comedy"
                },
                new Genre()
                {
                    Id = 11,
                    Name = "Supernatural"
                },
                new Genre()
                {
                    Id = 12,
                    Name = "Romance"
                }
         );
        }

        private void SeedGenreAnime(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<GenreAnime>().HasData(
                new GenreAnime()
                {
                    Id = 1,
                    GenreId = 1,
                    AnimeId = 9,
                },
                new GenreAnime()
                {
                    Id = 2,
                    GenreId = 8,
                    AnimeId = 9,
                },
                new GenreAnime()
                {
                    Id = 3,
                    GenreId = 2,
                    AnimeId = 9,
                },
                new GenreAnime()
                {
                    Id = 4,
                    GenreId = 6,
                    AnimeId = 9,
                },
                new GenreAnime()
                {
                    Id = 5,
                    GenreId = 9,
                    AnimeId = 8,
                },
                new GenreAnime()
                {
                    Id = 6,
                    GenreId = 1,
                    AnimeId = 8,
                },
                new GenreAnime()
                {
                    Id = 7,
                    GenreId = 6,
                    AnimeId = 8,
                },
                new GenreAnime()
                {
                    Id = 8,
                    GenreId = 1,
                    AnimeId = 7,
                },
                new GenreAnime()
                {
                    Id = 9,
                    GenreId = 10,
                    AnimeId = 7,
                },
                new GenreAnime()
                {
                    Id = 10,
                    GenreId = 6,
                    AnimeId = 7,
                },
                new GenreAnime()
                {
                    Id = 11,
                    GenreId = 11,
                    AnimeId = 6,
                },
                new GenreAnime()
                {
                    Id = 12,
                    GenreId = 9,
                    AnimeId = 6,
                },
                new GenreAnime()
                {
                    Id = 13,
                    GenreId = 7,
                    AnimeId = 6,
                },
                new GenreAnime()
                {
                    Id = 14,
                    GenreId = 2,
                    AnimeId = 5,
                },
                new GenreAnime()
                {
                    Id = 15,
                    GenreId = 12,
                    AnimeId = 5,
                },
                new GenreAnime()
                {
                    Id = 16,
                    GenreId = 1,
                    AnimeId = 4,
                },
                new GenreAnime()
                {
                    Id = 17,
                    GenreId = 6,
                    AnimeId = 4,
                },
                new GenreAnime()
                {
                    Id = 18,
                    GenreId = 7,
                    AnimeId = 4,
                },
                new GenreAnime()
                {
                    Id = 19,
                    GenreId = 6,
                    AnimeId = 3,
                },
                new GenreAnime()
                {
                    Id = 20,
                    GenreId = 8,
                    AnimeId = 3,
                },
                new GenreAnime()
                {
                    Id = 21,
                    GenreId = 10,
                    AnimeId = 3,
                },
                new GenreAnime()
                {
                    Id = 22,
                    GenreId = 1,
                    AnimeId = 2,
                },
                new GenreAnime()
                {
                    Id = 23,
                    GenreId = 4,
                    AnimeId = 2,
                },
                new GenreAnime()
                {
                    Id = 24,
                    GenreId = 6,
                    AnimeId = 2,
                },
                new GenreAnime()
                {
                    Id = 25,
                    GenreId = 2,
                    AnimeId = 10,
                },
                new GenreAnime()
                {
                    Id = 26,
                    GenreId = 6,
                    AnimeId = 10,
                },
                new GenreAnime()
                {
                    Id = 27,
                    GenreId = 1,
                    AnimeId = 1,
                },
                new GenreAnime()
                {
                    Id = 28,
                    GenreId = 2,
                    AnimeId = 1,
                },
                new GenreAnime()
                {
                    Id = 29,
                    GenreId = 3,
                    AnimeId = 1,
                },
                new GenreAnime()
                {
                    Id = 30,
                    GenreId = 7,
                    AnimeId = 11,
                },
                new GenreAnime()
                {
                    Id = 31,
                    GenreId = 3,
                    AnimeId = 11,
                },
                new GenreAnime()
                {
                    Id = 32,
                    GenreId = 7,
                    AnimeId = 12,
                },
                new GenreAnime()
                {
                    Id = 33,
                    GenreId = 11,
                    AnimeId = 12,
                },
                new GenreAnime()
                {
                    Id = 34,
                    GenreId = 3,
                    AnimeId = 12,
                },
                new GenreAnime()
                {
                    Id = 35,
                    GenreId = 1,
                    AnimeId = 13,
                },
                new GenreAnime()
                {
                    Id = 36,
                    GenreId = 6,
                    AnimeId = 13,
                },
                new GenreAnime()
                {
                    Id = 37,
                    GenreId = 9,
                    AnimeId = 13,
                },
                new GenreAnime()
                {
                    Id = 38,
                    GenreId = 3,
                    AnimeId = 13,
                },
                new GenreAnime()
                {
                    Id = 39,
                    GenreId = 1,
                    AnimeId = 14,
                },
                new GenreAnime()
                {
                    Id = 40,
                    GenreId = 8,
                    AnimeId = 15,
                },
                new GenreAnime()
                {
                    Id = 41,
                    GenreId = 10,
                    AnimeId = 15,
                },
                new GenreAnime()
                {
                    Id = 42,
                    GenreId = 12,
                    AnimeId = 15,
                },
                new GenreAnime()
                {
                    Id = 43,
                    GenreId = 6,
                    AnimeId = 15,
                },
                new GenreAnime()
                {
                    Id = 44,
                    GenreId = 3,
                    AnimeId = 17,
                },
                new GenreAnime()
                {
                    Id = 45,
                    GenreId = 11,
                    AnimeId = 17,
                },
                new GenreAnime()
                {
                    Id = 46,
                    GenreId = 9,
                    AnimeId = 20,
                },
                new GenreAnime()
                {
                    Id = 47,
                    GenreId = 7,
                    AnimeId = 20,
                },
                new GenreAnime()
                {
                    Id = 48,
                    GenreId = 11,
                    AnimeId = 20,
                },
                new GenreAnime()
                {
                    Id = 49,
                    GenreId = 1,
                    AnimeId = 21,
                },
                new GenreAnime()
                {
                    Id = 50,
                    GenreId = 11,
                    AnimeId = 21,
                },
                new GenreAnime()
                {
                    Id = 51,
                    GenreId = 1,
                    AnimeId = 22,
                },
                new GenreAnime()
                {
                    Id = 52,
                    GenreId = 8,
                    AnimeId = 22,
                },
                new GenreAnime()
                {
                    Id = 53,
                    GenreId = 6,
                    AnimeId = 22,
                },
                new GenreAnime()
                {
                    Id = 54,
                    GenreId = 12,
                    AnimeId = 22,
                },
                new GenreAnime()
                {
                    Id = 55,
                    GenreId = 1,
                    AnimeId = 16,
                },
                new GenreAnime()
                {
                    Id = 56,
                    GenreId = 4,
                    AnimeId = 16,
                },
                new GenreAnime()
                {
                    Id = 57,
                    GenreId = 2,
                    AnimeId = 16,
                },
                new GenreAnime()
                {
                    Id = 58,
                    GenreId = 5,
                    AnimeId = 16,
                },
                new GenreAnime()
                {
                    Id = 59,
                    GenreId = 1,
                    AnimeId = 18,
                },
                new GenreAnime()
                {
                    Id = 60,
                    GenreId = 9,
                    AnimeId = 18,
                },
                new GenreAnime()
                {
                    Id = 61,
                    GenreId = 5,
                    AnimeId = 18,
                },
                new GenreAnime()
                {
                    Id = 62,
                    GenreId = 1,
                    AnimeId = 19,
                },
                new GenreAnime()
                {
                    Id = 63,
                    GenreId = 2,
                    AnimeId = 19,
                },
                new GenreAnime()
                {
                    Id = 64,
                    GenreId = 11,
                    AnimeId = 19,
                }
         );
        }

        private void SeedUserRoles(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserRole>().HasData(
                new UserRole()
                {
                    Id = 1,
                    UserId = 1,
                    RoleId = 1,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 2,
                    UserId = 1,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 3,
                    UserId = 2,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 4,
                    UserId = 3,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 5,
                    UserId = 4,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 6,
                    UserId = 5,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 7,
                    UserId = 6,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                },
                new UserRole()
                {
                    Id = 8,
                    UserId = 7,
                    RoleId = 2,
                    CanReview = true,
                    CanAskQuestions = true,
                    CanParticipateInClubs = true,
                }
         );
        }

        private void SeedQA(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<QA>().HasData(
                new QA()
                {
                    Id = 1,
                    UserId = 2,
                    CategoryId = 2,
                    Question = "Can you explain Constellations?",
                    Answer = "Certainly. A Constellation in our Universe is made out of Stars. Similarly, Constellation in My Anime Galaxy is made out of Stars that each represent a list of anime grouped together by a common theme/genre/feeling - whatever the user decides. You can make custom Stars to add to your Constellation and give each of them a name. This is great if you want to save some anime for certain occasions, for example you may save Tokyo Ghoul in a Star named \"Horror\" or \"Gore\" and watch it when you have a craving for something bloody.",
                    Displayed = true
                },
                new QA()
                {
                    Id = 2,
                    UserId = 2,
                    CategoryId = 2,
                    Question = "How can I make my own watchlist?",
                    Answer = "",
                    Displayed = true
                },
                new QA()
                {
                    Id = 3,
                    UserId = 2,
                    CategoryId = 3,
                    Question = "I really like the look and feel of this app. I suggest you stick with the space theme:)",
                    Answer = "Thank you, I worked very hard on it. Of course, the space theme is a must!",
                    Displayed = true
                },
                new QA()
                {
                    Id = 4,
                    UserId = 5,
                    CategoryId = 4,
                    Question = "Can we get a clubs feature in this app?",
                    Answer = "It's in progress, it will be available once it's tested and ready.",
                    Displayed = true
                },
                new QA()
                {
                    Id = 5,
                    UserId = 3,
                    CategoryId = 1,
                    Question = "How long did it take you to make this app?",
                    Answer = "",
                    Displayed = true
                },
                new QA()
                {
                    Id = 6,
                    UserId = 4,
                    CategoryId = 1,
                    Question = "Where can I watch these anime?",
                    Answer = "You can try the official streaming services, such as Crunchyroll or Netflix.",
                    Displayed = true
                },
                new QA()
                {
                    Id = 7,
                    UserId = 5,
                    CategoryId = 1,
                    Question = "What was the inspiration behind My Anime Galaxy?",
                    Answer = "I had to choose something different, because professors were complaining about often-used app ideas.",
                    Displayed = true
                },
                new QA()
                {
                    Id = 8,
                    UserId = 5,
                    CategoryId = 1,
                    Question = "How do I create a star?",
                    Answer = "",
                    Displayed = true
                },
                new QA()
                {
                    Id = 9,
                    UserId = 4,
                    CategoryId = 1,
                    Question = "How do I add Anime to my Nebula?",
                    Answer = "",
                    Displayed = true
                },
                new QA()
                {
                    Id = 10,
                    UserId = 3,
                    CategoryId = 1,
                    Question = "Can I select a different language?",
                    Answer = "",
                    Displayed = true
                },
                new QA()
                {
                    Id =11,
                    UserId = 6,
                    CategoryId = 1,
                    Question = "Where can I turn on light mode?",
                    Answer = "Light mode has not been developed and it is not planned in the near future.",
                    Displayed = true
                }
         );
        }

        private void SeedWatchlists(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Watchlist>().HasData(
                new Watchlist()
                {
                    Id = 1,
                    UserId = 1,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 2,
                    UserId = 2,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 3,
                    UserId = 3,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 4,
                    UserId = 4,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 5,
                    UserId = 5,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 6,
                    UserId = 6,
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Watchlist()
                {
                    Id = 7,
                    UserId = 7,
                    DateAdded = new DateTime(2024, 7, 11)
                }
         );
        }

        private void SeedWatchlistAnime(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AnimeWatchlist>().HasData(
                new AnimeWatchlist()
                {
                    Id = 1,
                    AnimeId = 1,
                    WatchlistId = 2,
                    WatchStatus = "Watching",
                    Progress = 7,
                    DateStarted = new DateTime(2024, 7, 11),
                    DateFinished = null
                },
                new AnimeWatchlist()
                {
                    Id = 2,
                    AnimeId = 7,
                    WatchlistId = 2,
                    WatchStatus = "Completed",
                    Progress = 170,
                    DateStarted = new DateTime(2024, 3, 10),
                    DateFinished = new DateTime(2024, 4, 10)
                },
                new AnimeWatchlist()
                {
                    Id = 3,
                    AnimeId = 10,
                    WatchlistId = 2,
                    WatchStatus = "On Hold",
                    Progress = 5,
                    DateStarted = new DateTime(2024, 7, 11),
                    DateFinished = null
                },
                new AnimeWatchlist()
                {
                    Id = 4,
                    AnimeId = 5,
                    WatchlistId = 2,
                    WatchStatus = "Dropped",
                    Progress = 2,
                    DateStarted = new DateTime(2024, 7, 11),
                    DateFinished = null
                },
                new AnimeWatchlist()
                {
                    Id = 5,
                    AnimeId = 3,
                    WatchlistId = 2,
                    WatchStatus = "Plan to Watch",
                    Progress = 0,
                    DateStarted = null,
                    DateFinished = null
                }
         );
        }

        private void SeedLists(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<List>().HasData(
                new List()
                {
                    Id = 1,
                    UserId = 2,
                    Name = "Favorites",
                    DateCreated = new DateTime(2024, 7, 11)
                }
         );
        }

        private void SeedListAnime(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AnimeList>().HasData(
                new AnimeList()
                {
                    Id = 1,
                    ListId = 1,
                    AnimeId = 1,
                },
                new AnimeList()
                {
                    Id = 2,
                    ListId = 1,
                    AnimeId = 7,
                },
                new AnimeList()
                {
                    Id = 3,
                    ListId = 1,
                    AnimeId = 10,
                }
         );
        }

        private void SeedRatings(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Rating>().HasData(
                new Rating()
                {
                    Id = 1,
                    UserId = 2,
                    AnimeId = 1,
                    RatingValue = 10,
                    ReviewText = "Epic and intense, Attack on Titan captivates with its relentless action, intricate plot, and deep character development. The animation quality and soundtrack elevate it to a masterpiece of the genre.",
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Rating()
                {
                    Id = 2,
                    UserId = 2,
                    AnimeId = 7,
                    RatingValue = 9,
                    ReviewText = "Despite initial comparisons, Black Clover evolves into a compelling shonen series with exciting battles and character development. Asta's journey is filled with determination and magic.",
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Rating()
                {
                    Id = 3,
                    UserId = 2,
                    AnimeId = 10,
                    RatingValue = 8,
                    ReviewText = "Visually stunning and emotionally resonant, Violet Evergarden is a poetic exploration of love, loss, and self-discovery. The animation and music create a truly immersive experience",
                    DateAdded = new DateTime(2024, 7, 11)
                },
                new Rating()
                {
                    Id = 4,
                    UserId = 2,
                    AnimeId = 5,
                    RatingValue = 1,
                    ReviewText = "It is quite slow to be honest, not my cup of tea.",
                    DateAdded = new DateTime(2024, 7, 11)
                }
         );
        }

        private void SeedPreferredGenres(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PreferredGenre>().HasData(
                new PreferredGenre()
                {
                    Id = 1,
                    GenreId = 1,
                    UserId = 2
                },
                new PreferredGenre()
                {
                    Id = 2,
                    GenreId = 6,
                    UserId = 2
                },
                new PreferredGenre()
                {
                    Id = 3,
                    GenreId = 11,
                    UserId = 2
                },
                new PreferredGenre()
                {
                    Id = 4,
                    GenreId = 12,
                    UserId = 2
                },
                new PreferredGenre()
                {
                    Id = 5,
                    GenreId = 7,
                    UserId = 2
                },
                new PreferredGenre()
                {
                    Id = 6,
                    GenreId = 12,
                    UserId = 3
                },
                new PreferredGenre()
                {
                    Id = 7,
                    GenreId = 11,
                    UserId = 3
                },
                new PreferredGenre()
                {
                    Id = 8,
                    GenreId = 11,
                    UserId = 4
                },
                new PreferredGenre()
                {
                    Id = 9,
                    GenreId = 6,
                    UserId = 3
                },
                new PreferredGenre()
                {
                    Id = 10,
                    GenreId = 6,
                    UserId = 4
                },
                new PreferredGenre()
                {
                    Id = 11,
                    GenreId = 6,
                    UserId = 5
                },
                new PreferredGenre()
                {
                    Id = 12,
                    GenreId = 1,
                    UserId = 3
                },
                new PreferredGenre()
                {
                    Id = 13,
                    GenreId = 1,
                    UserId = 4
                },
                new PreferredGenre()
                {
                    Id = 14,
                    GenreId = 1,
                    UserId = 5
                },
                new PreferredGenre()
                {
                    Id = 15,
                    GenreId = 1,
                    UserId = 6
                }
         );
        }

        private void SeedDonations(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Donation>().HasData(
                new Donation()
                {
                    Id = 1,
                    UserId = 2,
                    Amount = 20,
                    DateDonated = new DateTime(2024, 7, 11),
                    TransactionId = "txn_3PijFYRsmg17Kngz1idOozHb"
                }
         );
        }

        private void SeedClubs(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Club>().HasData(
                new Club()
                {
                    Id = 1,
                    OwnerId = 5,
                    Name = "Black Clover Fans",
                    Description = "This is a club for all lovers of Black Clover! We discuss events from both anime and manga :D",
                    MemberCount = 0,
                    DateCreated = new DateTime(2024, 7, 11),
                    CoverId = 1
                },
                new Club()
                {
                    Id = 2,
                    OwnerId = 2,
                    Name = "Happy Campers",
                    Description = "Welcome and open to all well-mannered souls, for discussing all types of Anime and Manga :)",
                    MemberCount = 0,
                    DateCreated = new DateTime(2024, 7, 11),
                    CoverId = 1
                }
         );
        }

        private void SeedClubUser(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ClubUser>().HasData(
                new ClubUser()
                {
                    Id = 1,
                    ClubId = 1,
                    UserId = 2
                },
                new ClubUser()
                {
                    Id = 2,
                    ClubId = 1,
                    UserId = 5
                },
                new ClubUser()
                {
                    Id = 3,
                    ClubId = 1,
                    UserId = 1
                },
                new ClubUser()
                {
                    Id = 4,
                    ClubId = 1,
                    UserId = 3
                },
                new ClubUser()
                {
                    Id = 5,
                    ClubId = 1,
                    UserId = 4
                },
                new ClubUser()
                {
                    Id = 6,
                    ClubId = 2,
                    UserId = 2
                }
         );
        }

        private void SeedPosts(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>().HasData(
                new Post()
                {
                    Id = 1,
                    ClubId = 1,
                    UserId = 6,
                    Content = "Do you think Captain Vangeance got away easy after he betrayed the Clover Kingdom? He barely even got a slap on the wrist!",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DatePosted = new DateTime(2024, 7, 11)
                },
                new Post()
                {
                    Id = 2,
                    ClubId = 1,
                    UserId = 4,
                    Content = "I think William should have stayed the Golden Dawn captain. He's basically a GD icon, with his unique mask and abilities. Do you agree?",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DatePosted = new DateTime(2024, 7, 11)
                },
                new Post()
                {
                    Id = 3,
                    ClubId = 1,
                    UserId = 3,
                    Content = "Who do you like better, Mimosa or Noelle?",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DatePosted = new DateTime(2024, 7, 11)
                },
                new Post()
                {
                    Id = 4,
                    ClubId = 1,
                    UserId = 5,
                    Content = "Practicing my magic abilities takes time and effort. But gaining all those stars from the Wizard King sure is worth it!",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DatePosted = new DateTime(2024, 7, 11)
                }
         );
        }

        private void SeedComments(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Comment>().HasData(
                new Comment()
                {
                    Id = 1,
                    PostId = 1,
                    UserId = 4,
                    Content = "I don't know, maybe. He seems like an empathetic person, so choosing either side would have been devastating. Maybe Julius thought he suffered enough.",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DateCommented = new DateTime(2024, 7, 11)
                },
                new Comment()
                {
                    Id = 2,
                    PostId = 2,
                    UserId = 5,
                    Content = "I completely agree.",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DateCommented = new DateTime(2024, 7, 11)
                },
                new Comment()
                {
                    Id = 3,
                    PostId = 1,
                    UserId = 7,
                    Content = "Yeah, and because of his incompetence I had to step in and become the captain of the Golden Dawn. I expected more backbone from a man in such a high position.",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DateCommented = new DateTime(2024, 7, 11)
                },
                new Comment()
                {
                    Id = 4,
                    PostId = 4,
                    UserId = 7,
                    Content = "Agreed. That's why I work ten times as hard as anyone else. The one with most achievements is going to become the next Wizard King, and that's going to be me.",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DateCommented = new DateTime(2024, 7, 11)
                },
                new Comment()
                {
                    Id = 5,
                    PostId = 4,
                    UserId = 6,
                    Content = "It's been my experience that hard work repays tenfold when you most need it.",
                    LikesCount = 0,
                    DislikesCount = 0,
                    DateCommented = new DateTime(2024, 7, 11)
                }
         );
        }

    }
}

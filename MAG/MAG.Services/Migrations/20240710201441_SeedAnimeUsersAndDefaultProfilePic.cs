using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace MAG.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedAnimeUsersAndDefaultProfilePic : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 1,
                column: "Score",
                value: 0m);

            migrationBuilder.InsertData(
                table: "Anime",
                columns: new[] { "ID", "BeginAir", "EpisodesNumber", "FinishAir", "ImageURL", "Score", "Season", "Studio", "Synopsis", "TitleEN", "TitleJP", "TrailerURL" },
                values: new object[,]
                {
                    { 2, new DateTime(2019, 4, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 26, new DateTime(2019, 9, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1628/103229l.jpg", 0m, "Spring", "ufotable", "Ever since the death of his father, the burden of supporting the family has fallen upon Tanjirou Kamado's shoulders. Though living impoverished on a remote mountain, the Kamado family are able to enjoy a relatively peaceful and happy life. One day, Tanjirou decides to go down to the local village to make a little money selling charcoal. On his way back, night falls, forcing Tanjirou to take shelter in the house of a strange man, who warns him of the existence of flesh-eating demons that lurk in the woods at night.\r\n\r\nWhen he finally arrives back home the next day, he is met with a horrifying sight—his whole family has been slaughtered. Worse still, the sole survivor is his sister Nezuko, who has been turned into a bloodthirsty demon. Consumed by rage and hatred, Tanjirou swears to avenge his family and stay by his only remaining sibling. Alongside the mysterious group calling themselves the Demon Slayer Corps, Tanjirou will do whatever it takes to slay the demons and protect the remnants of his beloved sister's humanity.", "Demon Slayer", "Kimetsu no Yaiba", "https://youtu.be/6vMuWuWlW4I" },
                    { 3, new DateTime(2017, 1, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, new DateTime(2017, 6, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1884/120456l.jpg", 0m, "Winter", "Trigger", "\"A believing heart is your magic!\"—these were the words that Atsuko \"Akko\" Kagari's idol, the renowned witch Shiny Chariot, said to her during a magic performance years ago. Since then, Akko has lived by these words and aspired to be a witch just like Shiny Chariot, one that can make people smile. Hence, even her non-magical background does not stop her from enrolling in Luna Nova Magical Academy.    However, when an excited Akko finally sets off to her new school, the trip there is anything but smooth. After her perilous journey, she befriends the shy Lotte Yansson and the sarcastic Sucy Manbavaran. To her utmost delight, she also discovers Chariot's wand, the Shiny Rod, which she takes as her own. Unfortunately, her time at Luna Nova will prove to be more challenging than Akko could ever believe. She absolutely refuses to stay inferior to the rest of her peers, especially to her self-proclaimed rival, the beautiful and gifted Diana Cavendish, so she relies on her determination to compensate for her reckless behavior and ineptitude in magic.    In a time when wizardry is on the decline, Little Witch Academia follows the magical escapades of Akko and her friends as they learn the true meaning of being a witch.", "Little Witch Academia", "Little Witch Academia", "https://youtu.be/S3jFdqs4jUQ" },
                    { 4, new DateTime(2008, 10, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, new DateTime(2009, 3, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1467/137783l.jpg", 0m, "Fall", "A-1 Pictures", "Young Ciel Phantomhive is known as \"the Queen's Guard Dog,\" taking care of the many unsettling events that occur in Victorian England for Her Majesty. Aided by Sebastian Michaelis, his loyal butler with seemingly inhuman abilities, Ciel uses whatever means necessary to get the job done. But is there more to this black-clad butler than meets the eye?    In Ciel's past lies a secret tragedy that enveloped him in perennial darkness—during one of his bleakest moments, he formed a contract with Sebastian, a demon, bargaining his soul in exchange for vengeance upon those who wronged him. Today, not only is Sebastian one hell of a butler, but he is also the perfect servant to carry out his master's orders—all the while anticipating the delicious meal he will eventually make of Ciel's soul. As the two work to unravel the mystery behind Ciel's chain of misfortunes, a bond forms between them that neither heaven nor hell can tear apart.", "Black Butler", "Kuroshitsuji", "https://youtu.be/S8j5iEklHyI" },
                    { 5, new DateTime(2016, 7, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, new DateTime(2016, 9, 24, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/3/82149l.jpg", 0m, "Summer", "TMS Entertainment", "Dismissed as a hopeless loser by those around him, 27-year-old Arata Kaizaki bounces around from one job to another after quitting his first company. His unremarkable existence takes a sharp turn when he meets Ryou Yoake, a member of the ReLife Research Institute, who offers Arata the opportunity to change his life for the better with the help of a mysterious pill. Taking it without a second thought, Arata awakens the next day to find that his appearance has reverted to that of a 17-year-old.    Arata soon learns that he is now the subject of a unique experiment and must attend high school as a transfer student for one year. Though he initially believes it will be a cinch due to his superior life experience, Arata is proven horribly wrong on his first day: he flunks all his tests, is completely out of shape, and can't keep up with the new school policies that have cropped up in the last 10 years. Furthermore, Ryou has been assigned to observe him, bringing Arata endless annoyance. ReLIFE follows Arata's struggle to adjust to his hectic new lifestyle and avoid repeating his past mistakes, all while slowly discovering more about his fellow classmates.", "ReLIFE", "ReLIFE", "https://youtu.be/fZCgXuxMAZY" },
                    { 6, new DateTime(2012, 1, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2012, 3, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/4/75509l.jpg", 0m, "Winter", "P.A. Works", "In class 3-3 of Yomiyama North Junior High, transfer student Kouichi Sakakibara makes his return after taking a sick leave for the first month of school. Among his new classmates, he is inexplicably drawn toward Mei Misaki—a reserved girl with an eyepatch whom he met in the hospital during his absence. But none of his classmates acknowledge her existence; they warn him not to acquaint himself with things that do not exist. Against their words of caution, Kouichi befriends Mei—soon learning of the sinister truth behind his friends' apprehension.    The ominous rumors revolve around a former student of the class 3-3. However, no one will share the full details of the grim event with Kouichi. Engrossed in the curse that plagues his class, Kouichi sets out to discover its connection to his new friend. As a series of tragedies arise around them, it is now up to Kouichi, Mei, and their classmates to unravel the eerie mystery—but doing so will come at a hefty price.", "Another", "Another", "https://youtu.be/UGoAl3L13bc" },
                    { 7, new DateTime(2017, 10, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 170, new DateTime(2021, 3, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1232/93334l.jpg", 0m, "Fall", "Pierrot", "Asta and Yuno were abandoned at the same church on the same day. Raised together as children, they came to know of the \"Wizard King\"—a title given to the strongest mage in the kingdom—and promised that they would compete against each other for the position of the next Wizard King. However, as they grew up, the stark difference between them became evident. While Yuno is able to wield magic with amazing power and control, Asta cannot use magic at all and desperately tries to awaken his powers by training physically.    When they reach the age of 15, Yuno is bestowed a spectacular Grimoire with a four-leaf clover, while Asta receives nothing. However, soon after, Yuno is attacked by a person named Lebuty, whose main purpose is to obtain Yuno's Grimoire. Asta tries to fight Lebuty, but he is outmatched. Though without hope and on the brink of defeat, he finds the strength to continue when he hears Yuno's voice. Unleashing his inner emotions in a rage, Asta receives a five-leaf clover Grimoire, a \"Black Clover\" giving him enough power to defeat Lebuty. A few days later, the two friends head out into the world, both seeking the same goal—to become the Wizard King!", "Black Clover", "Black Clover", "https://youtu.be/vUjAxk1qYzQ" },
                    { 8, new DateTime(2014, 7, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2014, 9, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1498/134443l.jpg", 0m, "Winter", "Pierrot", "A sinister threat is invading Tokyo: flesh-eating \"ghouls\" who appear identical to humans and blend into their population. Reserved college student Ken Kaneki buries his nose in books and avoids the news of the growing crisis. However, the appearance of an attractive woman named Rize Kamishiro shatters his solitude when she forwardly asks him on a date.    While walking Rize home, Kaneki discovers she isn't as kind as she first appeared, and she has led him on with sinister intent. After a tragic struggle, he later awakens in a hospital to learn his life was saved by transplanting the now deceased Rize's organs into his own body.    Kaneki's body begins to change in horrifying ways, and he transforms into a human-ghoul hybrid. As he embarks on his new dreadful journey, Kaneki clings to his humanity in the evolving bloody conflict between society's new monsters and the government agents who hunt them.", "Tokyo Ghoul", "Tokyo Ghoul", "https://youtu.be/vGuQeQsoRgU" },
                    { 9, new DateTime(2009, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 64, new DateTime(2010, 7, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1208/94745l.jpg", 0m, "Spring", "Bones", "After a horrific alchemy experiment goes wrong in the Elric household, brothers Edward and Alphonse are left in a catastrophic new reality. Ignoring the alchemical principle banning human transmutation, the boys attempted to bring their recently deceased mother back to life. Instead, they suffered brutal personal loss: Alphonse's body disintegrated while Edward lost a leg and then sacrificed an arm to keep Alphonse's soul in the physical realm by binding it to a hulking suit of armor.    The brothers are rescued by their neighbor Pinako Rockbell and her granddaughter Winry. Known as a bio-mechanical engineering prodigy, Winry creates prosthetic limbs for Edward by utilizing \"automail,\" a tough, versatile metal used in robots and combat armor. After years of training, the Elric brothers set off on a quest to restore their bodies by locating the Philosopher's Stone—a powerful gem that allows an alchemist to defy the traditional laws of Equivalent Exchange.    As Edward becomes an infamous alchemist and gains the nickname \"Fullmetal,\" the boys' journey embroils them in a growing conspiracy that threatens the fate of the world.", "Fullmetal Alchemist: Brotherhood", "Fullmetal Alchemist: Brotherhood", "https://youtu.be/--IcmZkvL0Q" },
                    { 10, new DateTime(2018, 1, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, new DateTime(2018, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1795/95088l.jpg", 0m, "Winter", "Kyoto Animation", "The Great War finally came to an end after four long years of conflict; fractured in two, the continent of Telesis slowly began to flourish once again. Caught up in the bloodshed was Violet Evergarden, a young girl raised for the sole purpose of decimating enemy lines. Hospitalized and maimed in a bloody skirmish during the War's final leg, she was left with only words from the person she held dearest, but with no understanding of their meaning.    Recovering from her wounds, Violet starts a new life working at CH Postal Services after a falling out with her new intended guardian family. There, she witnesses by pure chance the work of an \"Auto Memory Doll,\" amanuenses that transcribe people's thoughts and feelings into words on paper. Moved by the notion, Violet begins work as an Auto Memory Doll, a trade that will take her on an adventure, one that will reshape the lives of her clients and hopefully lead to self-discovery.", "Violet Evergarden", "Violet Evergarden", "https://youtu.be/g5xWqjFglsk" },
                    { 11, new DateTime(2020, 10, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 11, new DateTime(2020, 12, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1464/108330l.jpg", 0m, "Fall", "Production I.G", "During the late 19th century, Great Britain has become the greatest empire the world has ever known. Hidden within its success, the nation's rigid economic hierarchy dictates the value of one's life solely on status and wealth. To no surprise, the system favors the aristocracy at the top and renders it impossible for the working class to ascend the ranks.    William James Moriarty, the second son of the Moriarty household, lives as a regular noble while also being a consultant for the common folk to give them a hand and solve their problems. However, deep inside him lies a desire to destroy the current structure that dominates British society and those who benefit from it.    Alongside his brothers Albert and Louis, William will do anything it takes to change the filthy world he lives in—even if blood must be spilled.", "Moriarty the Patriot", "Yuukoku no Moriarty", "https://youtu.be/YA_zLUnLaQM" },
                    { 12, new DateTime(2016, 1, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2016, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/10/77957l.jpg", 0m, "Winter", "A-1 Pictures", "When tragedy is about to strike, Satoru Fujinuma finds himself sent back several minutes before the accident occurs. The detached, 29-year-old manga artist has taken advantage of this powerful yet mysterious phenomenon, which he calls \"Revival,\" to save many lives.    However, when he is wrongfully accused of murdering someone close to him, Satoru is sent back to the past once again, but this time to 1988, 18 years in the past. Soon, he realizes that the murder may be connected to the abduction and killing of one of his classmates, the solitary and mysterious Kayo Hinazuki, that took place when he was a child. This is his chance to make things right.    Boku dake ga Inai Machi follows Satoru in his mission to uncover what truly transpired 18 years ago and prevent the death of his classmate while protecting those he cares about in the present.", "ERASED", "Boku dake ga Inai Machi", "https://youtu.be/DwmxEAWjTQQ" },
                    { 13, new DateTime(2016, 4, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2016, 7, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/4/77657l.jpg", 0m, "Spring", "Wit Studio", "The world is in the midst of the industrial revolution when horrific creatures emerge from a mysterious virus, ripping through the flesh of humans to sate their never-ending appetite. The only way to kill these beings, known as \"Kabane,\" is by destroying their steel-coated hearts. However, if bitten by one of these monsters, the victim is doomed to a fate worse than death, as the fallen rise once more to join the ranks of their fellow undead.    Only the most fortified of civilizations have survived this turmoil, as is the case with the island of Hinomoto, where mankind has created a massive wall to protect themselves from the endless hordes of Kabane. The only way into these giant fortresses is via heavily-armored trains, which are serviced and built by young men such as Ikoma. Having created a deadly weapon that he believes will easily pierce through the hearts of Kabane, Ikoma eagerly awaits the day when he will be able to fight using his new invention. Little does he know, however, that his chance will come much sooner than he expected...", "Kabaneri of the Iron Fortress", "Koutetsujou no Kabaneri", "https://youtu.be/NljBw9RtOx4" },
                    { 14, new DateTime(2016, 4, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 13, new DateTime(2016, 6, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1985/96688l.jpg", 0m, "Spring", "Bones", "The appearance of \"quirks,\" newly discovered super powers, has been steadily increasing over the years, with 80 percent of humanity possessing various abilities from manipulation of elements to shapeshifting. This leaves the remainder of the world completely powerless, and Izuku Midoriya is one such individual.    Since he was a child, the ambitious middle schooler has wanted nothing more than to be a hero. Izuku's unfair fate leaves him admiring heroes and taking notes on them whenever he can. But it seems that his persistence has borne some fruit: Izuku meets the number one hero and his personal idol, All Might. All Might's quirk is a unique ability that can be inherited, and he has chosen Izuku to be his successor!    Enduring many months of grueling training, Izuku enrolls in UA High, a prestigious high school famous for its excellent hero training program, and this year's freshmen look especially promising. With his bizarre but talented classmates and the looming threat of a villainous organization, Izuku will soon learn what it really means to be a hero.", "My Hero Academia", "Boku no Hero Academia ", "https://youtu.be/D5fYOnwYkj4" },
                    { 15, new DateTime(2003, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 52, new DateTime(2004, 3, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/3/9640l.jpg", 0m, "Spring", "Actas", "As the mermaid princess of the North Pacific (one of the seven mermaid kingdoms), Lucia entrusts a magical pearl to a boy who falls overboard a ship one night. Lucia must travel to the human world to reclaim her pearl and protect the mermaid kingdoms. Using the power of music Lucia is able to protect herself and the mermaid kingdoms from a growing evil force.", "Mermaid Melody: Pichi Pichi Pitch", "Mermaid Melody: Pichi Pichi Pitch", "https://youtu.be/0jjxJ1gCCSg?si=coVddH065Hmf9axl" },
                    { 16, new DateTime(2006, 10, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, new DateTime(2007, 7, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1073/91139l.jpg", 0m, "Fall", "Sunrise", "In the year 2010, the Holy Empire of Britannia is establishing itself as a dominant military nation, starting with the conquest of Japan. Renamed to Area 11 after its swift defeat, Japan has seen significant resistance against these tyrants in an attempt to regain independence.    Lelouch Lamperouge, a Britannian student, unfortunately finds himself caught in a crossfire between the Britannian and the Area 11 rebel armed forces. He is able to escape, however, thanks to the timely appearance of a mysterious girl named C.C., who bestows upon him Geass, the \"Power of Kings.\" Realizing the vast potential of his newfound \"power of absolute obedience,\" Lelouch embarks upon a perilous journey as the masked vigilante known as Zero, leading a merciless onslaught against Britannia in order to get revenge once and for all.", "Code Geass: Lelouch of the Rebellion", "Code Geass: Hangyaku no Lelouch", "https://youtu.be/ulQGo6X7kFo?si=SJcQZudCN13ob47U" },
                    { 17, new DateTime(2006, 10, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), 37, new DateTime(2007, 6, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1079/138100l.jpg", 0m, "Fall", "Madhouse", "Brutal murders, petty thefts, and senseless violence pollute the human world. In contrast, the realm of death gods is a humdrum, unchanging gambling den. The ingenious 17-year-old Japanese student Light Yagami and sadistic god of death Ryuk share one belief: their worlds are rotten.    For his own amusement, Ryuk drops his Death Note into the human world. Light stumbles upon it, deeming the first of its rules ridiculous: the human whose name is written in this note shall die. However, the temptation is too great, and Light experiments by writing a felon's name, which disturbingly enacts his first murder.    Aware of the terrifying godlike power that has fallen into his hands, Light—under the alias Kira—follows his wicked sense of justice with the ultimate goal of cleansing the world of all evil-doers. The meticulous mastermind detective L is already on his trail, but as Light's brilliance rivals L's, the grand chase for Kira turns into an intense battle of wits that can only end when one of them is dead.", "Death Note", "Death Note", "https://youtu.be/tJZtOrm-WPk?si=lFWxefLVUyPY8O3-" },
                    { 18, new DateTime(2014, 10, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), 24, new DateTime(2015, 3, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/3/73178l.jpg", 0m, "Fall", "Madhouse", "All of a sudden, they arrived: parasitic aliens that descended upon Earth and quickly infiltrated humanity by burrowing into the brains of vulnerable targets. These insatiable beings acquire full control of their host and are able to morph into a variety of forms in order to feed on unsuspecting prey.    Sixteen-year-old high school student Shinichi Izumi falls victim to one of these parasites, but it fails to take over his brain, ending up in his right hand instead. Unable to relocate, the parasite, now named Migi, has no choice but to rely on Shinichi in order to stay alive. Thus, the pair is forced into an uneasy coexistence and must defend themselves from hostile parasites that hope to eradicate this new threat to their species.", "Parasyte: The Maxim", "Kiseijuu: Sei no Kakuritsu", "https://youtu.be/9Oe9umzw1Gc" },
                    { 19, new DateTime(2015, 4, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2015, 6, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/5/73474l.jpg", 0m, "Spring", "Wit Studio", "With the appearance of a mysterious virus that kills everyone above the age of 13, mankind becomes enslaved by previously hidden, power-hungry vampires who emerge in order to subjugate society with the promise of protecting the survivors, in exchange for donations of their blood.    Among these survivors are Yuuichirou and Mikaela Hyakuya, two young boys who are taken captive from an orphanage, along with other children whom they consider family. Discontent with being treated like livestock under the vampires' cruel reign, Mikaela hatches a rebellious escape plan that is ultimately doomed to fail. The only survivor to come out on the other side is Yuuichirou, who is found by the Moon Demon Company, a military unit dedicated to exterminating the vampires in Japan.    Many years later, now a member of the Japanese Imperial Demon Army, Yuuichirou is determined to take revenge on the creatures that slaughtered his family, but at what cost?    Owari no Seraph is a post-apocalyptic supernatural shounen anime that follows a young man's search for retribution, all the while battling for friendship and loyalty against seemingly impossible odds.", "Seraph of the End: Vampire Reign", "Owari no Seraph", "https://youtu.be/NtzDAmRhD9s" },
                    { 20, new DateTime(2010, 7, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), 22, new DateTime(2010, 12, 31, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1531/119165l.jpg", 0m, "Summer", "Daume", "Life is idyllic and unassuming in the small town of Sotoba, a simple place where everyone knows everyone. However, tragedy strikes when Megumi Shimizu, a young girl with high aspirations, unexpectedly passes away from an unnamed illness. Over the torrid summer months, as more unexplained deaths crop up around the village, the town's doctor—Toshio Ozaki—begins to suspect that something more sinister than a mere disease is at play.    Toshio teams up with Natsuno Yuuki, an apathetic and aloof teenager, and siblings Kaori and Akira Tanaka, two of Megumi's friends, to unravel the dark mystery behind the deaths in Sotoba. With their combined efforts, the investigation leads them toward an eerie secret pertaining to the new family in the Kanemasa mansion.", "Shiki", "Shiki", "https://youtu.be/W6yEzWAd_vg?si=zZVV44m_vzstFp-U" },
                    { 21, new DateTime(2018, 7, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 12, new DateTime(2018, 9, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/1226/94893l.jpg", 0m, "Summer", "P.A. Works", "In the year 1930, vampires have infiltrated Tokyo to feast upon its unsuspecting citizens. As the number of victims continues to rise, the city's authorities decide to hire the Jaegers—a strange, diverse group of individuals tasked by the V Shipping Company to hunt down vampires around the world. Carrying musical instrument cases to disguise their identity, the Jaegers battle the vampires with the same mercilessness demonstrated by their foes.    Yuliy, the Jaeger's most skilled warrior, is the sole survivor of a vampire raid on his home village. Using the strength granted by his werewolf blood, he works with his team to assist Tokyo's law enforcement with the city's vampire problem. Though under the pretense of helping the police, the Jaegers are actually fighting the vampires over the mystical Ark of Sirius. With its power to change the fate of the world, Yuliy and his friends must locate the artifact before the vampires can use it to achieve their destructive goals.", "Sirius the Jaeger", "Sirius", "https://youtu.be/K1zgQyxJDio" },
                    { 22, new DateTime(2012, 7, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 25, new DateTime(2012, 12, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), "https://cdn.myanimelist.net/images/anime/8/36343l.jpg", 0m, "Summer", "A-1 Pictures", "Ever since the release of the innovative NerveGear, gamers from all around the globe have been given the opportunity to experience a completely immersive virtual reality. Sword Art Online (SAO), one of the most recent games on the console, offers a gateway into the wondrous world of Aincrad, a vivid, medieval landscape where users can do anything within the limits of imagination. With the release of this worldwide sensation, gaming has never felt more lifelike.    However, the idyllic fantasy rapidly becomes a brutal nightmare when SAO's creator traps thousands of players inside the game. The \"log-out\" function has been removed, with the only method of escape involving beating all of Aincrad's one hundred increasingly difficult levels. Adding to the struggle, any in-game death becomes permanent, ending the player's life in the real world.    While Kazuto \"Kirito\" Kirigaya was fortunate enough to be a beta-tester for the game, he quickly finds that despite his advantages, he cannot overcome SAO's challenges alone. Teaming up with Asuna Yuuki and other talented players, Kirito makes an effort to face the seemingly insurmountable trials head-on. But with difficult bosses and threatening dark cults impeding his progress, Kirito finds that such tasks are much easier said than done.", "Sword Art Online", "Sword Art Online", "https://youtu.be/6ohYYtxfDCg" }
                });

            migrationBuilder.InsertData(
                table: "UserProfilePicture",
                columns: new[] { "ID", "ProfilePicture" },
                values: new object[] { 1, new byte[] { 255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 1, 0, 96, 0, 96, 0, 0, 255, 219, 0, 67, 0, 6, 4, 5, 6, 5, 4, 6, 6, 5, 6, 7, 7, 6, 8, 10, 16, 10, 10, 9, 9, 10, 20, 14, 15, 12, 16, 23, 20, 24, 24, 23, 20, 22, 22, 26, 29, 37, 31, 26, 27, 35, 28, 22, 22, 32, 44, 32, 35, 38, 39, 41, 42, 41, 25, 31, 45, 48, 45, 40, 48, 37, 40, 41, 40, 255, 219, 0, 67, 1, 7, 7, 7, 10, 8, 10, 19, 10, 10, 19, 40, 26, 22, 26, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 255, 192, 0, 17, 8, 0, 100, 0, 100, 3, 1, 34, 0, 2, 17, 1, 3, 17, 1, 255, 196, 0, 31, 0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 196, 0, 181, 16, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 125, 1, 2, 3, 0, 4, 17, 5, 18, 33, 49, 65, 6, 19, 81, 97, 7, 34, 113, 20, 50, 129, 145, 161, 8, 35, 66, 177, 193, 21, 82, 209, 240, 36, 51, 98, 114, 130, 9, 10, 22, 23, 24, 25, 26, 37, 38, 39, 40, 41, 42, 52, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 255, 196, 0, 31, 1, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 255, 196, 0, 181, 17, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 119, 0, 1, 2, 3, 17, 4, 5, 33, 49, 6, 18, 65, 81, 7, 97, 113, 19, 34, 50, 129, 8, 20, 66, 145, 161, 177, 193, 9, 35, 51, 82, 240, 21, 98, 114, 209, 10, 22, 36, 52, 225, 37, 241, 23, 24, 25, 26, 38, 39, 40, 41, 42, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 130, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 226, 227, 228, 229, 230, 231, 232, 233, 234, 242, 243, 244, 245, 246, 247, 248, 249, 250, 255, 218, 0, 12, 3, 1, 0, 2, 17, 3, 17, 0, 63, 0, 250, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 168, 205, 169, 65, 27, 97, 115, 33, 255, 0, 103, 165, 84, 213, 174, 203, 185, 133, 15, 200, 188, 55, 185, 172, 218, 0, 215, 93, 93, 115, 243, 194, 192, 123, 54, 106, 245, 189, 204, 87, 3, 49, 54, 72, 234, 59, 138, 230, 169, 200, 236, 140, 25, 9, 12, 57, 4, 80, 7, 83, 69, 87, 177, 184, 23, 48, 6, 232, 195, 134, 30, 245, 98, 128, 10, 40, 162, 128, 10, 40, 162, 128, 10, 40, 162, 128, 10, 142, 225, 252, 168, 36, 127, 238, 169, 53, 37, 67, 120, 165, 237, 38, 3, 174, 195, 138, 0, 230, 201, 207, 90, 74, 40, 160, 2, 138, 40, 160, 13, 13, 22, 77, 183, 69, 59, 58, 254, 163, 252, 154, 219, 172, 29, 33, 119, 94, 169, 254, 232, 39, 250, 127, 90, 222, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 2, 138, 40, 160, 14, 114, 250, 220, 219, 206, 87, 31, 41, 229, 79, 181, 87, 174, 154, 226, 20, 158, 50, 146, 14, 59, 30, 226, 178, 46, 52, 217, 99, 63, 187, 195, 175, 110, 112, 104, 2, 133, 21, 97, 108, 231, 99, 129, 31, 230, 64, 173, 27, 61, 48, 70, 193, 231, 33, 152, 114, 20, 116, 160, 7, 105, 22, 230, 40, 140, 142, 48, 207, 211, 216, 86, 133, 20, 80, 1, 69, 20, 80, 1, 69, 20, 80, 1, 69, 20, 140, 193, 20, 179, 16, 0, 228, 147, 64, 3, 48, 85, 37, 136, 0, 117, 38, 179, 110, 117, 69, 94, 32, 93, 199, 251, 199, 165, 82, 190, 188, 123, 150, 32, 28, 69, 217, 125, 106, 165, 0, 88, 150, 242, 226, 67, 243, 74, 192, 122, 47, 21, 92, 242, 114, 121, 62, 180, 81, 64, 5, 62, 57, 30, 63, 245, 110, 203, 244, 56, 166, 81, 64, 23, 224, 212, 230, 76, 121, 152, 144, 123, 240, 107, 82, 214, 238, 43, 129, 242, 28, 55, 117, 61, 107, 156, 165, 86, 42, 192, 169, 32, 142, 132, 80, 7, 85, 69, 81, 211, 111, 62, 208, 187, 36, 226, 69, 31, 157, 94, 160, 2, 138, 40, 160, 2, 179, 53, 169, 138, 198, 145, 47, 241, 114, 126, 149, 167, 85, 174, 108, 226, 184, 144, 60, 155, 178, 6, 56, 52, 1, 206, 209, 91, 191, 217, 118, 255, 0, 237, 254, 116, 127, 101, 219, 255, 0, 183, 249, 208, 6, 21, 21, 187, 253, 151, 111, 254, 223, 231, 71, 246, 93, 191, 251, 127, 157, 0, 97, 81, 91, 191, 217, 118, 255, 0, 237, 254, 116, 127, 101, 219, 255, 0, 183, 249, 208, 6, 21, 21, 187, 253, 151, 111, 254, 223, 231, 71, 246, 93, 191, 251, 127, 157, 0, 98, 195, 33, 138, 85, 117, 234, 167, 53, 211, 163, 7, 69, 97, 209, 134, 69, 82, 254, 203, 183, 255, 0, 111, 243, 171, 145, 32, 142, 53, 69, 206, 213, 24, 25, 160, 7, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 0, 81, 69, 20, 1, 255, 217 } });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "ID", "DateJoined", "Email", "FirstName", "LastName", "PasswordHash", "PasswordSalt", "ProfilePictureID", "Username" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3317), "ena.balic@edu.fit.ba", "Ena", "Balić", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Administrator" },
                    { 2, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3365), null, "Mikaela", "Hyakuya", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Mika" },
                    { 3, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3369), null, "Muzan", "Kibutsuji", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Master-Muzan" },
                    { 4, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3373), null, "Julius", "Novachrono", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Chronovala" },
                    { 5, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3376), null, "Vanessa", "Enoteca", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "ThreadOfFate" },
                    { 6, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3380), null, "William", "Vangeance", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Captain-William" },
                    { 7, new DateTime(2024, 7, 10, 22, 14, 41, 70, DateTimeKind.Local).AddTicks(3384), null, "Yuno", "Grinberryall", "my/ELwTcrvtQ7tlVYibJNnISjtw=", "u9Rht8UH9bvKrDQnbeNh7A==", 1, "Yuno" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "UserProfilePicture",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.UpdateData(
                table: "Anime",
                keyColumn: "ID",
                keyValue: 1,
                column: "Score",
                value: null);
        }
    }
}

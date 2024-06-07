-- Run this block if you already have a database and need to re-create it
DELETE FROM Users;
DELETE FROM DemotionQueue;
DELETE FROM Subscriptions;
DELETE FROM Posts;
DELETE FROM Comments;
DELETE FROM Reactions;
DELETE FROM PostReactions;
DELETE FROM Tags;
DELETE FROM PostTags;
DELETE FROM Categories;

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS DemotionQueue;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Reactions;
DROP TABLE IF EXISTS PostReactions;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS PostTags;
DROP TABLE IF EXISTS Categories;
-- End block


CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);

CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "date" date,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);


INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Sports');
INSERT INTO Categories ('label') VALUES ('Home Improvement');
INSERT INTO Categories ('label') VALUES ('Fashion');
INSERT INTO Categories ('label') VALUES ('Gardening');
INSERT INTO Categories ('label') VALUES ('Trending');
INSERT INTO Categories ('id', 'label') VALUES (0, 'Uncategorized');


INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Tags ('label') VALUES ('Music');
INSERT INTO Tags ('label') VALUES ('Home Improvement');
INSERT INTO Tags ('label') VALUES ('Gardening');
INSERT INTO Tags ('label') VALUES ('Trending');


INSERT INTO PostTags ('post_id', 'tag_id') VALUES (4, 6);
INSERT INTO PostTags ('post_id', 'tag_id') VALUES (4, 8);
INSERT INTO PostTags ('post_id', 'tag_id') VALUES (4, 12);
INSERT INTO PostTags ('post_id', 'tag_id') VALUES (4, 2);


INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');



INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active')
  VALUES (
  'William', 
  'Woodard', 
  'williamwoodard@email.com', 
  'im very cool',
  'william_runs',
  'running12345',
  'https://upload.wikimedia.org/wikipedia/commons/1/12/William_Submarines_Crop.png',
  '05/29/2024',
  1
);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active')
  VALUES (
  'Blake', 
  'Smith', 
  'blakesmith@email.com', 
  'im very extremely cool',
  'blake_reads_good',
  'reading12345',
  'https://hips.hearstapps.com/hmg-prod/images/blake-shelton-gettyimages-1229169132.jpg',
  '05/29/2024',
  1
);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active')
  VALUES (
  'Leah', 
  'Sanders', 
  'leahsanders@email.com', 
  'im a lot cool',
  'leah_bakes',
  'baking12345',
  'https://lumiere-a.akamaihd.net/v1/images/leia-organa-main_9af6ff81.jpeg?region=367%2C153%2C1043%2C784',
  '05/29/2024',
  1
);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active')
  VALUES (
  'Niki', 
  'Powell', 
  'nikipowell@email.com', 
  'im a lot a lot cool',
  'niki_climbs',
  'climbing12345',
  'https://www.rollingstone.com/wp-content/uploads/2023/11/Nicki-Minaj-vogue-cover.jpg?w=1581&h=1054&crop=1',
  '05/29/2024',
  1
);


INSERT INTO comments ('post_id', 'author_id', 'date', 'content')
  VALUES (12, 4, '05-14-2024 03:19:27 PM', 'This speaks true!');
INSERT INTO comments ('post_id', 'author_id', 'date', 'content')
  VALUES (14, 2, '05-15-2024 11:11:11 PM', 'I doubt this is actually true. Seems kinda crazy. People will write anything for attention these days.');


INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  1,
  0,
  'The Endurance and Passion of Marathon Running',
  '05/30/2024',
  'https://t3.ftcdn.net/jpg/02/41/54/00/360_F_241540051_OnZfvfMAz2csZ7XMCyOB1BGSZkIhc3mr.jpg',
  'Marathon running is a sport that epitomizes endurance, dedication, and the triumph of the human spirit. Covering a distance of 26.2 miles, the marathon challenges runners to push beyond their physical and mental limits, making it one of the most demanding athletic feats. The history of the marathon dates back to ancient Greece, inspired by the legendary run of Pheidippides, a Greek soldier who purportedly ran from the battlefield of Marathon to Athens to announce a military victory. This historic run has evolved into a modern race, first introduced in the 1896 Athens Olympics. Today, marathons are held globally, attracting runners of all ages and backgrounds. Training for a marathon requires meticulous planning and unwavering commitment. Runners often follow rigorous training programs that span several months, incorporating long-distance runs, speed work, strength training, and proper nutrition. The preparation not only builds physical stamina but also mental toughness, as runners must overcome fatigue and self-doubt to reach their goals. One of the unique aspects of marathon running is its inclusivity. Marathons welcome elite athletes competing for titles and personal records, as well as amateur runners pursuing personal milestones and charity goals. Major marathons like the Boston Marathon, London Marathon, and New York City Marathon attract thousands of participants and spectators, creating a vibrant, communal atmosphere. The race day experience is a culmination of months of hard work. Runners face varying terrain, weather conditions, and the infamous "wall"—a point where glycogen stores are depleted, and the body struggles to continue. Overcoming this phase requires immense mental fortitude and determination. Crossing the finish line is a moment of profound accomplishment, often accompanied by a flood of emotions and a sense of camaraderie with fellow runners. Marathon running also promotes health and wellness. The discipline involved in training encourages a healthy lifestyle, including balanced nutrition and regular exercise. The sport fosters a sense of community, with runners sharing tips, support, and motivation. In essence, marathon running is more than just a race; it is a journey of personal growth, resilience, and community spirit. It exemplifies the power of perseverance and the joy of achieving seemingly impossible goals, making it a truly inspiring sport.',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  2,
  0,
  'The Excitement and Elegance of Tennis',
  '05/29/2024',
  'https://images.freeimages.com/images/large-previews/6ad/tennis-fun-1-1398467.jpg?fmt=webp&w=500',
  'Tennis, a sport that elegantly combines athleticism, strategy, and grace, has captivated audiences around the world for centuries. From the pristine grass courts of Wimbledon to the vibrant clay of Roland Garros, tennis showcases a unique blend of tradition and modernity, making it a beloved global pastime. The origins of tennis can be traced back to 12th-century France, where it began as a game played with the hand. Over time, it evolved, incorporating rackets and formalized rules, eventually becoming the sport we recognize today. Modern tennis is played on various surfaces, each offering distinct challenges and influencing the style of play. Grass courts, known for their fast pace and low bounce, demand swift reflexes and precision. Clay courts slow the ball down, emphasizing stamina and strategic placement. Hard courts provide a balanced playing field, rewarding a blend of power and agility. One of the most compelling aspects of tennis is the one-on-one competition. Unlike team sports, tennis places athletes in direct opposition, testing their mental and physical endurance. Matches can be grueling, sometimes lasting several hours, and require not only peak physical fitness but also psychological resilience. Players must strategize on the fly, adjusting their tactics to counter their strengths and exploit weaknesses. Tennis has produced some of the most iconic athletes in sports history. Legends like Roger Federer, Serena Williams, Rafael Nadal, and Steffi Graf have transcended the sport, becoming global icons through their remarkable achievements and sportsmanship. Their rivalries and comebacks add a dramatic flair to the sport, captivating fans and inspiring the next generation of players. The global appeal is also evident in its widespread participation and viewership. Grand Slam tournaments draw millions of viewers, with fans eagerly following the highs and lows of their favorite players. Tennis clubs and public courts worldwide encourage people of all ages and skill levels to pick up a racket and enjoy the game. In essence, tennis is more than just a sport; it is a celebration of human athleticism, skill, and perseverance. Its rich history, global reach, and the sheer excitement of the matches ensure that tennis will continue to be a beloved pastime for generations to come.',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  2,
  0,
  'The Joys of Bird Watching',
  '05/29/2024',
  'https://media.istockphoto.com/id/153187546/photo/bird-watcher-silhouette.jpg?s=612x612&w=0&k=20&c=egbpMOqQYff7JwluOQP8rgwH05cVa_FCs54B-eYUVaU=',
  'Bird watching is a serene and fulfilling hobby that brings people closer to nature. It involves observing birds in their natural habitats, noting their behaviors, and appreciating their diverse species. This pastime offers a unique way to connect with the environment and discover the wonders of the avian world.
  One of the primary attractions of bird watching is its simplicity. All that is needed are a pair of binoculars and a field guide to start identifying birds. Bird watchers often visit parks, forests, wetlands, and even their own backyards to find different species. The thrill of spotting a rare bird or witnessing interesting behavior can be incredibly rewarding.
  Bird watching is not just about seeing birds; it is also about listening to them. Bird songs and calls are distinctive and can help identify species even when they are not visible. Learning to recognize these sounds adds another layer of enjoyment and skill to the hobby.
  This activity has numerous benefits. It promotes patience and mindfulness, as bird watchers often spend long periods being still and quiet to avoid startling the birds. This can be a meditative experience, allowing individuals to escape the hustle and bustle of daily life and immerse themselves in nature.
  Bird watching also contributes to conservation efforts. By noting the presence and behavior of different species, bird watchers can provide valuable data that helps scientists track bird populations and monitor environmental health. Many bird watchers participate in citizen science projects, contributing their observations to databases that aid in conservation research.
  Bird watching can be enjoyed alone or as a social activity. Joining a bird watching group or club provides opportunities to learn from more experienced watchers and share discoveries. These communities often organize outings and events, fostering camaraderie among members.
  In conclusion, bird watching is a delightful and accessible hobby that enriches lives through a deeper connection with nature. Whether spotting a vibrant warbler or hearing the call of an owl at dusk, bird watching offers endless moments of joy and discovery.',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  4,
  0,
  'The Thrill of Rock Climbing',
  '05/29/2024',
  'https://t3.ftcdn.net/jpg/01/02/78/60/360_F_102786052_nKiHITs3tRMnzINk8uWvtvCdkRSS3eHh.jpg',
  'Rock climbing is a captivating sport that combines physical strength, mental acuity, and a deep appreciation for nature. Whether scaling indoor walls or tackling rugged outdoor cliffs, rock climbing offers an exhilarating experience that challenges both the body and the mind.
  One of the most appealing aspects of rock climbing is its versatility. Climbers can choose from various styles, including bouldering, sport climbing, and traditional climbing. Bouldering involves climbing short but intense routes without ropes, focusing on strength and technique. Sport climbing uses fixed anchors for protection, allowing climbers to tackle longer routes with the security of a rope. Traditional climbing, or trad climbing, requires placing and removing gear as one ascends, demanding a high level of skill and knowledge.
  The physical benefits of rock climbing are substantial. It is a full-body workout that builds muscle, improves endurance, and enhances flexibility. Climbers develop strong cores, powerful legs, and increased grip strength. The sport also boosts cardiovascular fitness, as climbing often involves sustained physical effort over extended periods.
  Mental toughness is equally crucial in rock climbing. Climbers must assess routes, solve problems on the fly, and maintain focus under pressure. This mental challenge fosters resilience and sharpens problem-solving skills. Overcoming the fear of heights and learning to trust ones equipment and abilities can be profoundly empowering.
  Rock climbing is also a gateway to breathtaking natural landscapes. Outdoor climbing spots are often located in stunning settings, from towering mountain ranges to serene coastal cliffs. Climbing allows individuals to experience these environments in a unique and intimate way, fostering a deep connection with nature.
  Community is another vital aspect of rock climbing. Climbers often form tight-knit groups, supporting and encouraging one another. Whether at a local climbing gym or a remote crag, the shared experience of tackling challenging routes creates strong bonds and a sense of camaraderie.
  In summary, rock climbing is a dynamic sport that offers numerous physical and mental benefits. Its combination of strength, strategy, and natural beauty makes it a rewarding and invigorating pursuit for adventurers of all levels. Whether a novice or an experienced climber, the thrill of ascending a rock face is an unparalleled experience.',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  3,
  0,
  'The Joy of Baking',
  '05/29/2024',
  'https://t3.ftcdn.net/jpg/02/41/83/66/360_F_241836684_19cuQm3CbIWAyeuZH2l8ZKuwZrDnOJDF.jpg',
  'Baking is an art form that combines creativity, precision, and patience. It is a process that transforms simple ingredients into delicious and comforting treats. Whether you are making bread, cookies, or cakes, baking offers a sense of satisfaction and joy that is hard to match.
  One of the best aspects of baking is its accessibility. With just a few basic tools and ingredients, anyone can start baking at home. Flour, sugar, eggs, and butter are the foundation of many recipes. With these staples and a bit of practice, you can create a wide variety of baked goods.
  Baking requires precision and attention to detail. Measuring ingredients accurately is crucial to achieving the desired result. Too much flour can make your cookies dry, while too little can make your bread dense. Following a recipe closely ensures that your baked goods turn out perfectly every time.
  The process of baking is also deeply therapeutic. Mixing dough, kneading bread, and decorating cakes can be a meditative experience. The repetitive motions and focus required can help to reduce stress and promote relaxation. Plus, the aroma of freshly baked goods filling your home is a delightful bonus.
  Baking is also a wonderful way to connect with others. Sharing homemade treats with family and friends brings people together and creates lasting memories. Baking for special occasions, such as birthdays and holidays, adds a personal touch that is always appreciated.
  Experimentation is another exciting aspect of baking. Once you are comfortable with the basics, you can start to explore new flavors and techniques. Adding spices, nuts, or fruit to a recipe can create a unique twist. Trying different types of flour or sweeteners can also yield interesting results.
  In conclusion, baking is a rewarding and enjoyable hobby that offers numerous benefits. It allows you to create delicious treats, practice precision, reduce stress, and connect with others. Whether you are a novice or an experienced baker, the joy of baking is something that everyone can appreciate.',
  1
);


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
INSERT INTO Tags ('label') VALUES ('JavaScript');
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
  VALUES (1, 4, '5/14/2024', 'This speaks true!');
INSERT INTO comments ('post_id', 'author_id', 'date', 'content')
  VALUES (1, 2, '5/15/2024', 'I doubt this is actually true. Seems kinda crazy. People will write anything for attention these days.');

INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  1,
  1,
  'This is a Post Title',
  '05/30/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for This specific Post, ya hear?',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  2,
  1,
  'Blakes Post Title',
  '05/31/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for Blakes post ya hear buddy?',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  2,
  1,
  'Blakes Older Post Title',
  '05/29/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for Blakes older post to test ordering the display of posts from newest to oldest ya hear buddy?',
  1
);



  INSERT INTO Categories ('label') VALUES ('Cat 2');
  INSERT INTO Categories ('label') VALUES ('Cat 3');

  2,
  1,
  'Blakes Future Post Title',
  '06/01/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for Blakes Future post its a post from the future',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  4,
  1,
  'Niki Got Herself a Post!',
  '05/29/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for Nikis post. its really cool stuff',
  1
);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date','image_url', 'content', 'approved')
  VALUES (
  3,
  1,
  'Leah Got Herself a Post!',
  '05/29/2024',
  'https://cdn.abcteach.com/abcteach-content-free/docs/free_preview/n/newspaper_rgb_p.png',
  'This is the Content for Leahs post. how ya like them apples?',
  1
);


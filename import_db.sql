CREATE TABLE users
(
id INTEGER PRIMARY KEY,
fname VARCHAR(20),
lname VARCHAR(20)
);

CREATE TABLE questions
(
id INTEGER PRIMARY KEY,
title VARCHAR(80),
body TEXT,
author_id INTEGER,
FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_followers
(
id INTEGER PRIMARY KEY,
user_id INTEGER,
question_id INTEGER,
FOREIGN KEY(question_id) REFERENCES questions(id),
FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE replies
(
id INTEGER PRIMARY KEY,
question_id INTEGER,
parent_id INTEGER,
author_id INTEGER,
body TEXT,
FOREIGN KEY(question_id) REFERENCES questions(id),
FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_likes
(
id INTEGER PRIMARY KEY,
question_id INTEGER,
user_id INTEGER,
FOREIGN KEY (question_id) REFERENCES questions(id),
FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (fname, lname)
VALUES
("Angelo","Kramvis"),
("Liz","Starin"),
("Curious","George");

INSERT INTO questions (title, body, author_id)
VALUES
("Why is the sky blue?", "I don't understand it!", 2),
("Why is water wet?", "I don't understand it!", 3),
("Where is my tail?", "Why don't I have one?", 1);

INSERT INTO question_followers (user_id, question_id)
VALUES (2,3),
       (1,3),
       (3,3),
       (1,2),
       (3,1),
       (3,2);


INSERT INTO replies (question_id, parent_id, author_id, body)
VALUES
(1, NULL, 1, "It just is."),
(1, 1, 3, "I like the sky!"),
(1, 2, 2, "You guys are not helping!"),
(2, NULL, 1, "Because it isn't dry.");

INSERT INTO question_likes (question_id, user_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(3, 3);



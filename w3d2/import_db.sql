DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER,

  FOREIGN KEY(author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,


  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_id INTEGER,
  author_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,


  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('eli', 'lee'),
  ('nevin', 'daniel');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('why?', 'sdghjspojgsdg', (SELECT id FROM users WHERE fname = 'nevin')),
  ('because?', 'sabndzibulaiowlhe', (SELECT id FROM users WHERE fname = 'eli'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'nevin'), (SELECT id FROM questions WHERE title = 'because?') ),
  ((SELECT id FROM users WHERE fname = 'eli'), (SELECT id FROM questions WHERE title = 'because?') );

INSERT INTO
  replies(question_id, parent_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'because?'), NULL, (SELECT id FROM users WHERE fname = 'nevin'), 'asdl;fjas;df' ),
  ((SELECT id FROM questions WHERE title = 'because?'), NULL, (SELECT id FROM users WHERE fname = 'eli'), 'wel;fjawjfoei' );

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'nevin'),(SELECT id FROM questions WHERE title = 'why?') ),
  ((SELECT id FROM users WHERE fname = 'eli'), (SELECT id FROM questions WHERE title = 'why?') );

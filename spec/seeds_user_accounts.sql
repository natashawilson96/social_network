TRUNCATE TABLE user_accounts RESTART IDENTITY CASCADE;
-- TRUNCATE TABLE posts RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('makers@abc.com', 'MakersAbc');
INSERT INTO user_accounts (email_address, username) VALUES ('hello@work.com', 'Potato123');

-- INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Great', 'Interesting post', '120', '2');
-- INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Not good', 'Boring words', '5', '1');

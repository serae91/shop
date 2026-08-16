INSERT INTO carts
VALUES (nextval('carts_sequence'), (select id from users where username = 'testuser'), NOW());

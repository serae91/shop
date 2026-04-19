INSERT INTO carts
VALUES (nextval('carts_sequence'), (select id from users where username = 'user'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user1'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user2'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user3'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user4'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user5'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user6'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user7'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user8'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user9'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user10'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user11'), NOW()),
       (nextval('carts_sequence'), (select id from users where username = 'user12'), NOW());

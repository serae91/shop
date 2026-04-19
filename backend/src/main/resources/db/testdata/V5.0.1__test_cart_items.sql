INSERT INTO cart_items
VALUES (nextval('cart_items_sequence'), 1, (select id from products where name = 'Pokémon'), 42),
       (nextval('cart_items_sequence'), 1, (select id from products where name = 'Teddy'), 22),
       (nextval('cart_items_sequence'), 1, (select id from products where name = 'Chair'), 32),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'Table'), 2),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'T-Shirt'), 4),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'Pullover'), 142),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'Pokémon'), 4),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'Pants'), 3),
       (nextval('cart_items_sequence'), 2, (select id from products where name = 'Cupboard'), 1),
       (nextval('cart_items_sequence'), 3, (select id from products where name = 'Bed'), 6),
       (nextval('cart_items_sequence'), 3, (select id from products where name = 'Pokémon'), 8),
       (nextval('cart_items_sequence'), 3, (select id from products where name = 'Train'), 9),
       (nextval('cart_items_sequence'), 3, (select id from products where name = 'Table'), 19);

INSERT INTO cart_items
VALUES (nextval('cart_items_sequence'), 1, (select id from products where name = 'Pokémon'), 42),
       (nextval('cart_items_sequence'), 1, (select id from products where name = 'Teddy'), 22),
       (nextval('cart_items_sequence'), 1, (select id from products where name = 'Chair'), 32);

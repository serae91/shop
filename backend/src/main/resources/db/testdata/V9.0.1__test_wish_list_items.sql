INSERT INTO wish_list_items
VALUES (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Pokémon')),
       (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Teddy')),
       (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Chair'));

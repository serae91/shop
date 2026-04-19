INSERT INTO wish_list_items
VALUES (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Pokémon')),
       (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Teddy')),
       (nextval('wish_list_items_sequence'), 1, (select id from products where name = 'Chair')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'Table')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'T-Shirt')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'Pullover')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'Pokémon')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'Pants')),
       (nextval('wish_list_items_sequence'), 2, (select id from products where name = 'Cupboard')),
       (nextval('wish_list_items_sequence'), 3, (select id from products where name = 'Bed')),
       (nextval('wish_list_items_sequence'), 3, (select id from products where name = 'Pokémon')),
       (nextval('wish_list_items_sequence'), 3, (select id from products where name = 'Train')),
       (nextval('wish_list_items_sequence'), 3, (select id from products where name = 'Table'));

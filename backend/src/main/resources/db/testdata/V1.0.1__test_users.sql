INSERT INTO users
VALUES (nextval('users_sequence'),
        'e3d6ede8-32be-4e02-a943-2ae53b05fa81',
        'testuser',
        'test@example.com',
        'CUSTOMER',
        NOW(),
        NOW())
;

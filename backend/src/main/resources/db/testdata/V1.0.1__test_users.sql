INSERT INTO users
VALUES (nextval('users_sequence'),
        '1',
        'user',
        'user@email.com',
        'USER',
        NOW(),
        NOW())
;

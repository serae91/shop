CREATE SEQUENCE shop_user_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE shop_user
(
    id             BIGINT                   PRIMARY KEY,
    username       VARCHAR(255)             NOT NULL UNIQUE,
    password_hash  VARCHAR(255)             NOT NULL ,
    created_at     TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    email          VARCHAR(255)             NOT NULL UNIQUE,
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

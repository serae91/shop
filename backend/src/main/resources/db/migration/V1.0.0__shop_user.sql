CREATE SEQUENCE shop_user_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE shop_user
(
    id               BIGINT                   PRIMARY KEY,
    first_name       CHARACTER VARYING(100)   NOT NULL,
    last_name        CHARACTER VARYING(100)   NOT NULL,
    email            CHARACTER VARYING(255)   NOT NULL UNIQUE,
    billing_address  TEXT                     NOT NULL,
    shipping_address TEXT                     NOT NULL,
    password_hash    CHARACTER VARYING(255)   NOT NULL,
    created_at       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

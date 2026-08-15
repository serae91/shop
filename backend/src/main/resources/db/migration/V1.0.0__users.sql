CREATE SEQUENCE users_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE users
(
    id          BIGINT PRIMARY KEY DEFAULT nextval('users_sequence'),

    keycloak_id UUID NOT NULL UNIQUE,

    username    VARCHAR(100) NOT NULL UNIQUE,
    email       VARCHAR(255) UNIQUE,

    role        VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER',

    created_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (email IS NULL OR email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);
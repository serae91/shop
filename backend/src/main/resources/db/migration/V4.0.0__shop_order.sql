CREATE SEQUENCE shop_order_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE shop_order
(
    id           BIGINT                PRIMARY KEY,
    shop_user_id BIGINT                REFERENCES shop_user(id),
    status       CHARACTER VARYING(20) NOT NULL DEFAULT 'pending',
    total_amount NUMERIC(10,2)         NOT NULL CHECK (total_amount >= 0),
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at   TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
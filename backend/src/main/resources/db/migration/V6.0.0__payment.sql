CREATE SEQUENCE payment_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE payment
(
    id             BIGINT                 PRIMARY KEY,
    order_id       BIGINT                 REFERENCES shop_order(id),
    payment_method CHARACTER VARYING(50)  NOT NULL,
    amount         NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    status         CHARACTER VARYING(20)  NOT NULL DEFAULT 'pending',
    created_at     TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
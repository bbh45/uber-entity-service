CREATE TABLE otp
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    created_at     datetime NOT NULL,
    updated_at     datetime NOT NULL,
    code           VARCHAR(255) NULL,
    sent_to_number VARCHAR(255) NULL,
    CONSTRAINT pk_otp PRIMARY KEY (id)
);



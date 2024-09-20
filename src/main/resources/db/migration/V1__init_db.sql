CREATE TABLE driver
(
    id             BIGINT AUTO_INCREMENT NOT NULL,
    created_at     datetime     NOT NULL,
    updated_at     datetime     NOT NULL,
    name           VARCHAR(255) NOT NULL,
    license_number VARCHAR(255) NOT NULL,
    phone_number   VARCHAR(255) NULL,
    aadhar_card    VARCHAR(255) NULL,
    rating DOUBLE NULL,
    is_available   BIT(1)       NOT NULL,
    CONSTRAINT pk_driver PRIMARY KEY (id)
);

CREATE TABLE passenger
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    created_at   datetime     NOT NULL,
    updated_at   datetime     NOT NULL,
    name         VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email        VARCHAR(255) NOT NULL,
    password     VARCHAR(255) NOT NULL,
    rating DOUBLE NULL,
    CONSTRAINT pk_passenger PRIMARY KEY (id)
);

ALTER TABLE driver
    ADD CONSTRAINT uc_driver_license_number UNIQUE (license_number);

ALTER TABLE passenger
    ADD CONSTRAINT uc_passenger_email UNIQUE (email);
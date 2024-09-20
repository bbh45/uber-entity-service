CREATE TABLE exact_location
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    created_at datetime NOT NULL,
    updated_at datetime NOT NULL,
    latitude DOUBLE NULL,
    longitude DOUBLE NULL,
    CONSTRAINT pk_exactlocation PRIMARY KEY (id)
);

CREATE TABLE named_location
(
    id                BIGINT AUTO_INCREMENT NOT NULL,
    created_at        datetime NOT NULL,
    updated_at        datetime NOT NULL,
    exact_location_id BIGINT NULL,
    name              VARCHAR(255) NULL,
    zipcode           VARCHAR(255) NULL,
    city              VARCHAR(255) NULL,
    country           VARCHAR(255) NULL,
    state             VARCHAR(255) NULL,
    CONSTRAINT pk_namedlocation PRIMARY KEY (id)
);

ALTER TABLE named_location
    ADD CONSTRAINT FK_NAMEDLOCATION_ON_EXACT_LOCATION FOREIGN KEY (exact_location_id) REFERENCES exact_location (id);


ALTER TABLE passenger
    ADD active_booking_id BIGINT NULL;

ALTER TABLE passenger
    ADD home_id BIGINT NULL;

ALTER TABLE passenger
    ADD last_known_location_id BIGINT NULL;

ALTER TABLE driver
    ADD active_city VARCHAR(255) NULL;

ALTER TABLE driver
    ADD driver_approval_status ENUM('APPROVED','DENIED','PENDING') NULL;

ALTER TABLE driver
    ADD home_id BIGINT NULL;

ALTER TABLE driver
    ADD last_known_location_id BIGINT NULL;

CREATE TABLE booking
(
    id                BIGINT AUTO_INCREMENT NOT NULL,
    created_at        datetime NOT NULL,
    updated_at        datetime NOT NULL,
    booking_status    ENUM('SCHEDULED','CANCELLED','CAB_ARRIVED','ASSIGNING_DRIVER','IN_RIDE','COMPLETED') NULL,
    start_time        datetime NULL,
    end_time          datetime NULL,
    total_distance    BIGINT NULL,
    driver_id         BIGINT NULL,
    passenger_id      BIGINT NULL,
    start_location_id BIGINT NULL,
    end_location_id   BIGINT NULL,
    CONSTRAINT pk_booking PRIMARY KEY (id)
);

CREATE TABLE booking_review
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    created_at datetime     NOT NULL,
    updated_at datetime     NOT NULL,
    content    VARCHAR(255) NOT NULL,
    rating DOUBLE NULL,
    booking_id BIGINT       NOT NULL,
    CONSTRAINT pk_booking_review PRIMARY KEY (id)
);

CREATE TABLE passenger_bookings
(
    passenger_id BIGINT NOT NULL,
    bookings_id  BIGINT NOT NULL
);

CREATE TABLE passenger_review
(
    id                       BIGINT       NOT NULL,
    passenger_review_content VARCHAR(255) NOT NULL,
    passenger_rating         VARCHAR(255) NOT NULL,
    CONSTRAINT pk_passengerreview PRIMARY KEY (id)
);





ALTER TABLE booking_review
    ADD CONSTRAINT uc_booking_review_booking UNIQUE (booking_id);

ALTER TABLE passenger_bookings
    ADD CONSTRAINT uc_passenger_bookings_bookings UNIQUE (bookings_id);

ALTER TABLE booking
    ADD CONSTRAINT FK_BOOKING_ON_DRIVER FOREIGN KEY (driver_id) REFERENCES driver (id);

ALTER TABLE booking
    ADD CONSTRAINT FK_BOOKING_ON_END_LOCATION FOREIGN KEY (end_location_id) REFERENCES exact_location (id);

ALTER TABLE booking
    ADD CONSTRAINT FK_BOOKING_ON_PASSENGER FOREIGN KEY (passenger_id) REFERENCES passenger (id);

ALTER TABLE booking
    ADD CONSTRAINT FK_BOOKING_ON_START_LOCATION FOREIGN KEY (start_location_id) REFERENCES exact_location (id);

ALTER TABLE booking_review
    ADD CONSTRAINT FK_BOOKING_REVIEW_ON_BOOKING FOREIGN KEY (booking_id) REFERENCES booking (id);

ALTER TABLE driver
    ADD CONSTRAINT FK_DRIVER_ON_HOME FOREIGN KEY (home_id) REFERENCES exact_location (id);

ALTER TABLE driver
    ADD CONSTRAINT FK_DRIVER_ON_LAST_KNOWN_LOCATION FOREIGN KEY (last_known_location_id) REFERENCES exact_location (id);

ALTER TABLE passenger_review
    ADD CONSTRAINT FK_PASSENGERREVIEW_ON_ID FOREIGN KEY (id) REFERENCES booking_review (id);

ALTER TABLE passenger
    ADD CONSTRAINT FK_PASSENGER_ON_ACTIVE_BOOKING FOREIGN KEY (active_booking_id) REFERENCES booking (id);

ALTER TABLE passenger
    ADD CONSTRAINT FK_PASSENGER_ON_HOME FOREIGN KEY (home_id) REFERENCES exact_location (id);

ALTER TABLE passenger
    ADD CONSTRAINT FK_PASSENGER_ON_LAST_KNOWN_LOCATION FOREIGN KEY (last_known_location_id) REFERENCES exact_location (id);

ALTER TABLE passenger_bookings
    ADD CONSTRAINT fk_pasboo_on_booking FOREIGN KEY (bookings_id) REFERENCES booking (id);

ALTER TABLE passenger_bookings
    ADD CONSTRAINT fk_pasboo_on_passenger FOREIGN KEY (passenger_id) REFERENCES passenger (id);

ALTER TABLE driver
    ADD CONSTRAINT check_rating CHECK ( driver.rating > 0 AND driver.rating <= 5 )
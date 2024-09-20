package com.bb.uber_entity_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class UberEntityServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(UberEntityServiceApplication.class, args);
	}

}

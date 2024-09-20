package com.bb.uber_entity_service.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Future;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.util.List;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Driver extends BaseModel{

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String licenseNumber;

    private String phoneNumber;

    private String aadharCard;

    @OneToOne(mappedBy = "driver", cascade = CascadeType.ALL)
    private Car car;

    @Enumerated(value = EnumType.STRING)
    private DriverApprovalStatus driverApprovalStatus;

    @OneToOne
    private ExactLocation lastKnownLocation;

    @OneToOne
    private ExactLocation home;

    private String activeCity;

    @DecimalMin(value = "0.00", message = "Rating must be grater than or equal to 0.00")
    @DecimalMax(value = "5.00", message = "Rating must be less than or equal to 5.00")
    private Double rating;

    private boolean isAvailable;

    @OneToMany(mappedBy = "driver")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<Booking> bookings;
}


package com.teamone.tyremonitoring.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "tyre_data")
public class TyreData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private float temperature; // Temperature in °C
    private float pressure;   // Pressure in bar
    private int vibration;     // Vibration level
    private String tilt;       // Tilt status
    private float speed;       // Speed in km/h
    private double latitude;  // Latitude
    private double longitude; // Longitude
    private float tkph;       // TKPH value

    private LocalDateTime timestamp; // Timestamp of the data

    @PrePersist
    protected void onCreate() {
        timestamp = LocalDateTime.now(); // Set timestamp when data is saved
    }
}
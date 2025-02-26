package org.example.cab.Admin.model;

public class Vehicle {
    private int id;
    private String category;
    private String vehicleNumber;
    private String cc;
    private String engineNo;
    private String vehiclePhoto;
    private boolean available;
    private String fuelType;
    private int seatCapacity;
    private double rentalPrice;
    private int driverId;

    // Default constructor
    public Vehicle() {
    }

    // Parameterized constructor
    public Vehicle(int id, String category, String vehicleNumber, String cc, String engineNo, String vehiclePhoto,
                   boolean available, String fuelType, int seatCapacity, double rentalPrice, int driverId) {
        this.id = id;
        this.category = category;
        this.vehicleNumber = vehicleNumber;
        this.cc = cc;
        this.engineNo = engineNo;
        this.vehiclePhoto = vehiclePhoto;
        this.available = available;
        this.fuelType = fuelType;
        this.seatCapacity = seatCapacity;
        this.rentalPrice = rentalPrice;
        this.driverId = driverId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getCc() {
        return cc;
    }

    public void setCc(String cc) {
        this.cc = cc;
    }

    public String getEngineNo() {
        return engineNo;
    }

    public void setEngineNo(String engineNo) {
        this.engineNo = engineNo;
    }

    public String getVehiclePhoto() {
        return vehiclePhoto;
    }

    public void setVehiclePhoto(String vehiclePhoto) {
        this.vehiclePhoto = vehiclePhoto;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public int getSeatCapacity() {
        return seatCapacity;
    }

    public void setSeatCapacity(int seatCapacity) {
        this.seatCapacity = seatCapacity;
    }

    public double getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }
}

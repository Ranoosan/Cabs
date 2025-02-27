package org.example.cab.Driver.model;

import java.util.List;

public class User {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String emailAddress; // Changed from 'email' to 'emailAddress' for consistency
    private String contactNumber;
    private String residentialAddress; // Added field
    private String licenseNumber; // Added field
    private String licenseType; // Added field
    private String expirationDate; // Added field
    private String bankAccountNumber; // Added field
    private String medicalCertificate; // Added field
    private String emergencyContactDetails; // Added field
    private String copyOfDrivingLicense; // Added field
    private String proofOfAddress; // Added field
    private boolean termsAccepted; // Added field (assuming this is a boolean)
    private List<Vehicle> vehicles; // Added list of vehicles

    // Constructors
    public User() {
    }

    public User(int id, String username, String password, String fullName, String emailAddress, String contactNumber,
                String residentialAddress, String licenseNumber, String licenseType, String expirationDate,
                String bankAccountNumber, String medicalCertificate, String emergencyContactDetails,
                String copyOfDrivingLicense, String proofOfAddress, boolean termsAccepted, List<Vehicle> vehicles) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.emailAddress = emailAddress;
        this.contactNumber = contactNumber;
        this.residentialAddress = residentialAddress;
        this.licenseNumber = licenseNumber;
        this.licenseType = licenseType;
        this.expirationDate = expirationDate;
        this.bankAccountNumber = bankAccountNumber;
        this.medicalCertificate = medicalCertificate;
        this.emergencyContactDetails = emergencyContactDetails;
        this.copyOfDrivingLicense = copyOfDrivingLicense;
        this.proofOfAddress = proofOfAddress;
        this.termsAccepted = termsAccepted;
        this.vehicles = vehicles; // Initialize the vehicles list
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getResidentialAddress() {
        return residentialAddress;
    }

    public void setResidentialAddress(String residentialAddress) {
        this.residentialAddress = residentialAddress;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(String licenseType) {
        this.licenseType = licenseType;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getBankAccountNumber() {
        return bankAccountNumber;
    }

    public void setBankAccountNumber(String bankAccountNumber) {
        this.bankAccountNumber = bankAccountNumber;
    }

    public String getMedicalCertificate() {
        return medicalCertificate;
    }

    public void setMedicalCertificate(String medicalCertificate) {
        this.medicalCertificate = medicalCertificate;
    }

    public String getEmergencyContactDetails() {
        return emergencyContactDetails;
    }

    public void setEmergencyContactDetails(String emergencyContactDetails) {
        this.emergencyContactDetails = emergencyContactDetails;
    }

    public String getCopyOfDrivingLicense() {
        return copyOfDrivingLicense;
    }

    public void setCopyOfDrivingLicense(String copyOfDrivingLicense) {
        this.copyOfDrivingLicense = copyOfDrivingLicense;
    }

    public String getProofOfAddress() {
        return proofOfAddress;
    }

    public void setProofOfAddress(String proofOfAddress) {
        this.proofOfAddress = proofOfAddress;
    }

    public boolean isTermsAccepted() {
        return termsAccepted;
    }

    public void setTermsAccepted(boolean termsAccepted) {
        this.termsAccepted = termsAccepted;
    }

    public List<Vehicle> getVehicles() {
        return vehicles;
    }

    public void setVehicles(List<Vehicle> vehicles) {
        this.vehicles = vehicles;
    }
}

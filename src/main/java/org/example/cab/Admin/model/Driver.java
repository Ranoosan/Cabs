package org.example.cab.Admin.model;

import java.time.LocalDate;

public class Driver {
    private int id;
    private String username;
    private String password;
    private String full_Name;
    private String contact_Number;
    private String email_Address;
    private String residential_Address;
    private String license_Number;
    private String license_Type;
    private LocalDate expiration_Date;
    private String bank_Account_Number;
    private String emergency_Contact_Details;
    private String medical_Certificate; // New field
    private String copy_Of_Driving_License; // New field
    private String proof_Of_Address; // New field
    private boolean terms_Accepted; // New field

    public Driver() {}

    public Driver(int id, String username, String password, String full_Name, String contact_Number, String email_Address, String residential_Address, String license_Number, String license_Type, LocalDate expiration_Date, String bank_Account_Number, String emergency_Contact_Details, String medical_Certificate, String copy_Of_Driving_License, String proof_Of_Address, boolean terms_Accepted) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.full_Name = full_Name;
        this.contact_Number = contact_Number;
        this.email_Address = email_Address;
        this.residential_Address = residential_Address;
        this.license_Number = license_Number;
        this.license_Type = license_Type;
        this.expiration_Date = expiration_Date;
        this.bank_Account_Number = bank_Account_Number;
        this.emergency_Contact_Details = emergency_Contact_Details;
        this.medical_Certificate = medical_Certificate;
        this.copy_Of_Driving_License = copy_Of_Driving_License;
        this.proof_Of_Address = proof_Of_Address;
        this.terms_Accepted = terms_Accepted;
    }

    // Getters and setters for all fields

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return full_Name; }
    public void setFullName(String fullName) { this.full_Name = fullName; }

    public String getContactNumber() { return contact_Number; }
    public void setContactNumber(String contactNumber) { this.contact_Number = contactNumber; }

    public String getEmailAddress() { return email_Address; }
    public void setEmailAddress(String emailAddress) { this.email_Address = emailAddress; }

    public String getResidentialAddress() { return residential_Address; }
    public void setResidentialAddress(String residentialAddress) { this.residential_Address = residentialAddress; }

    public String getLicenseNumber() { return license_Number; }
    public void setLicenseNumber(String licenseNumber) { this.license_Number = licenseNumber; }

    public String getLicenseType() { return license_Type; }
    public void setLicenseType(String licenseType) { this.license_Type = licenseType; }

    public LocalDate getExpirationDate() { return expiration_Date; }
    public void setExpirationDate(LocalDate expirationDate) { this.expiration_Date = expirationDate; }

    public String getBankAccountNumber() { return bank_Account_Number; }
    public void setBankAccountNumber(String bankAccountNumber) { this.bank_Account_Number = bankAccountNumber; }

    public String getEmergencyContactDetails() { return emergency_Contact_Details; }
    public void setEmergencyContactDetails(String emergencyContactDetails) { this.emergency_Contact_Details = emergencyContactDetails; }

    public String getMedicalCertificate() { return medical_Certificate; }
    public void setMedicalCertificate(String medicalCertificate) { this.medical_Certificate = medicalCertificate; }

    public String getCopyOfDrivingLicense() { return copy_Of_Driving_License; }
    public void setCopyOfDrivingLicense(String copyOfDrivingLicense) { this.copy_Of_Driving_License = copyOfDrivingLicense; }

    public String getProofOfAddress() { return proof_Of_Address; }
    public void setProofOfAddress(String proofOfAddress) { this.proof_Of_Address = proofOfAddress; }

    public boolean isTermsAccepted() { return terms_Accepted; }
    public void setTermsAccepted(boolean termsAccepted) { this.terms_Accepted = termsAccepted; }

    @Override
    public String toString() {
        return "Driver{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", full_Name='" + full_Name + '\'' +
                ", contact_Number='" + contact_Number + '\'' +
                ", email_Address='" + email_Address + '\'' +
                ", residential_Address='" + residential_Address + '\'' +
                ", license_Number='" + license_Number + '\'' +
                ", license_Type='" + license_Type + '\'' +
                ", expiration_Date=" + expiration_Date +
                ", bank_Account_Number='" + bank_Account_Number + '\'' +
                ", emergency_Contact_Details='" + emergency_Contact_Details + '\'' +
                ", medical_Certificate='" + medical_Certificate + '\'' +
                ", copy_Of_Driving_License='" + copy_Of_Driving_License + '\'' +
                ", proof_Of_Address='" + proof_Of_Address + '\'' +
                ", terms_Accepted=" + terms_Accepted +
                '}';
    }
}

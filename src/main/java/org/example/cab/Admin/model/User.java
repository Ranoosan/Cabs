package org.example.cab.Admin.model;

import java.util.Date;

public class User {
    private int userId;  // Add the userId field
    private String username;
    private String password;
    private String email;
    private String contactNumber;
    private String address;
    private String gender;
    private String nic;
    private Date dateOfBirth;

    // Default constructor
    public User() {}

    // Parameterized constructor
    public User(int userId, String username, String password, String email, String contactNumber, String address, String gender, String nic, Date dateOfBirth) {
        this.userId = userId;  // Initialize userId
        this.username = username;
        this.password = password;
        this.email = email;
        this.contactNumber = contactNumber;
        this.address = address;
        this.gender = gender;
        this.nic = nic;
        this.dateOfBirth = dateOfBirth;
    }
    public User(String username, String password, String email, String contactNumber,
                String address, String gender, String nic, Date dateOfBirth) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.contactNumber = contactNumber;
        this.address = address;
        this.gender = gender;
        this.nic = nic;
        this.dateOfBirth = dateOfBirth;
    }

    // Getters and Setters
    public int getUserId() {
        return this.userId;  // Return userId
    }

    public void setUserId(int userId) {
        this.userId = userId;  // Set userId
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
}

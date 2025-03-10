package org.example.cab.customer.model;

import java.util.Date;

public class User {
    private int id;
    private String username;
    private String password;
    private String email;
    private String contactNumber;
    private String address;
    private String gender;
    private String nic;
    private Date dateOfBirth;


    public User() {}

    public User(int id, String username, String password, String email, String contactNumber, String address, String gender, String nic, Date dateOfBirth) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.contactNumber = contactNumber;
        this.address = address;
        this.gender = gender;
        this.nic = nic;
        this.dateOfBirth = dateOfBirth;

    }

    public User(String username, String password, String email, String contactNumber, String address, String gender, String nic, String dateOfBirth) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.contactNumber = contactNumber;
        this.address = address;
        this.gender = gender;
        this.nic = nic;
//        this.dateOfBirth = Date.valueOf(dateOfBirth); // Convert String to java.sql.Date
    }


    // Getters and Setters
    public int getId(User user) {return id;}
    public void setId(int id) {this.id = id;}

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", address='" + address + '\'' +
                ", gender='" + gender + '\'' +
                ", nic='" + nic + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                '}';
    }


}

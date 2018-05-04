package cn.zsh.hmspringboot.dto;

import javax.persistence.*;

/**
 * @author kilodleif
 */
@Table(name = "hm_user")
public class HmUser {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long userId;

    @Column
    private String account;

    @Column
    private String password;

    @Column
    private String userType;

    @Transient
    private String name;

    @Transient
    private String gender;

    @Transient
    private String telephone;

    @Transient
    private String address;

    @Transient
    private String email;

    public HmUser() {
    }

    public HmUser(String account) {
        this.account = account;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}

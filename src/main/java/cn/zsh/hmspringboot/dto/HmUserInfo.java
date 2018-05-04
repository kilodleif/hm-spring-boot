package cn.zsh.hmspringboot.dto;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author kilodleif
 */
@Table(name = "hm_user_info")
public class HmUserInfo {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long infoId;

    @Column
    private Long userId;

    @Column
    private String name;

    @Column
    private String gender;

    @Column
    private String telephone;

    @Column
    private String email;

    @Column
    private String address;

    public HmUserInfo() {
    }

    public HmUserInfo(Long userId) {
        this.userId = userId;
    }

    public Long getInfoId() {
        return infoId;
    }

    public void setInfoId(Long infoId) {
        this.infoId = infoId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

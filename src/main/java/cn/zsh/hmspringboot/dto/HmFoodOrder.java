package cn.zsh.hmspringboot.dto;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @author kilodleif
 */
@Table(name = "hm_food_order")
public class HmFoodOrder {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long orderId;

    @Column
    private Long userId;

    @Transient
    private String account;

    @Column
    private Date createTime;

    @Column
    private Date handleTime;

    @Column
    private String orderStatus;

    @Column
    private String sendAddress;

    @Transient
    private List<HmFoodOrderDetail> orderDetails;

    @Transient
    private Float totalPrice;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(Date handleTime) {
        this.handleTime = handleTime;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<HmFoodOrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<HmFoodOrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getSendAddress() {
        return sendAddress;
    }

    public void setSendAddress(String sendAddress) {
        this.sendAddress = sendAddress;
    }
}

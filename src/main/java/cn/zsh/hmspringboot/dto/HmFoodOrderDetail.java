package cn.zsh.hmspringboot.dto;

import javax.persistence.*;

/**
 * @author kilodleif
 */
@Table(name = "hm_food_order_detail")
public class HmFoodOrderDetail {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long detailId;

    @Column
    private Long orderId;

    @Column
    private Long foodId;

    @Transient
    private HmFood food;

    @Column
    private Integer amount;

    public Long getDetailId() {
        return detailId;
    }

    public void setDetailId(Long detailId) {
        this.detailId = detailId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getFoodId() {
        return foodId;
    }

    public void setFoodId(Long foodId) {
        this.foodId = foodId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public HmFood getFood() {
        return food;
    }

    public void setFood(HmFood food) {
        this.food = food;
    }
}

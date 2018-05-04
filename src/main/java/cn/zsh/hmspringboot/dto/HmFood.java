package cn.zsh.hmspringboot.dto;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author kilodleif
 */
@Table(name = "hm_food")
public class HmFood {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long foodId;

    @Column
    private String foodName;

    @Column
    private Float foodPrice;

    @Column
    private Integer leftAmount;

    public Long getFoodId() {
        return foodId;
    }

    public void setFoodId(Long foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public Float getFoodPrice() {
        return foodPrice;
    }

    public void setFoodPrice(Float foodPrice) {
        this.foodPrice = foodPrice;
    }

    public Integer getLeftAmount() {
        return leftAmount;
    }

    public void setLeftAmount(Integer leftAmount) {
        this.leftAmount = leftAmount;
    }
}

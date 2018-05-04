package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmFoodOrder;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmFoodOrderService {

    void addFoodOrder(HmFoodOrder foodOrder);

    List<HmFoodOrder> queryFoodOrder(HmFoodOrder condition, int page, int pageSize);

    void sendFood(HmFoodOrder order);

}

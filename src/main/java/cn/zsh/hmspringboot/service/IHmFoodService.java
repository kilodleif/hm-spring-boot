package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmFood;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmFoodService {

    List<HmFood> queryAvailableFood(HmFood condition, int page, int pageSize);

    List<HmFood> queryAll(int page, int pageSize);

    void addFood(HmFood food);

    void updateFood(HmFood food);

}

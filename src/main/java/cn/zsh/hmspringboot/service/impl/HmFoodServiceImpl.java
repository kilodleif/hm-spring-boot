package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmFood;
import cn.zsh.hmspringboot.mapper.HmFoodMapper;
import cn.zsh.hmspringboot.service.IHmFoodService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmFoodServiceImpl implements IHmFoodService {

    @Autowired
    private HmFoodMapper mapper;

    @Override
    public List<HmFood> queryAvailableFood(HmFood condition, int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        return mapper.selectFuzzily(condition);
    }

    @Override
    public List<HmFood> queryAll(int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        return mapper.select(new HmFood());
    }

    @Override
    public void addFood(HmFood food) {
        mapper.insertSelective(food);
    }

    @Override
    public void updateFood(HmFood food) {
        mapper.updateByPrimaryKeySelective(food);
    }
}

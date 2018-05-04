package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmFoodOrder;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmFoodOrderMapper extends Mapper<HmFoodOrder> {

    List<HmFoodOrder> selectFoodOrderWithDetail(HmFoodOrder condition);

}

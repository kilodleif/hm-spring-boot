package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmFoodOrderDetail;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmFoodOrderDetailMapper extends Mapper<HmFoodOrderDetail> {

    List<HmFoodOrderDetail> selectWithFoodName(Long orderId);

}

package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmFood;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmFoodMapper extends Mapper<HmFood> {

    List<HmFood> selectFuzzily(HmFood condition);
}

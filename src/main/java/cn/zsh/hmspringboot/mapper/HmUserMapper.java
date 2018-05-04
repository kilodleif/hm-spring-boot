package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmUser;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmUserMapper extends Mapper<HmUser> {

    List<HmUser> listUserAndInfo(HmUser condition);

}

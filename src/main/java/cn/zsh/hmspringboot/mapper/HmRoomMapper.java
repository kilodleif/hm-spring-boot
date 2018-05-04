package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmRoom;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmRoomMapper extends Mapper<HmRoom> {

    List<HmRoom> selectFree(HmRoom condition);
}

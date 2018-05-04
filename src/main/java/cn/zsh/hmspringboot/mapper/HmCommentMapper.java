package cn.zsh.hmspringboot.mapper;

import cn.zsh.hmspringboot.dto.HmComment;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author kilodleif
 */
public interface HmCommentMapper extends Mapper<HmComment> {

    List<HmComment> selectAllComment();

}

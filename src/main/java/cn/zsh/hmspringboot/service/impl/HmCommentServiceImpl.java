package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmComment;
import cn.zsh.hmspringboot.mapper.HmCommentMapper;
import cn.zsh.hmspringboot.service.IHmCommentService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmCommentServiceImpl implements IHmCommentService {

    @Autowired
    private HmCommentMapper mapper;

    @Override
    public List<HmComment> getAllCommentByPage(int page) {
        PageHelper.startPage(page, 10);
        return mapper.selectAllComment();
    }

    @Override
    public int addComment(HmComment comment) {
        return mapper.insertSelective(comment);
    }

    @Override
    public void deleteComment(Long commentId) {
        mapper.deleteByPrimaryKey(commentId);
    }
}

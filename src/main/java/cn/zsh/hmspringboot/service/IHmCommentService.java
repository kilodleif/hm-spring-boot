package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmComment;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmCommentService {

    List<HmComment> getAllCommentByPage(int page);

    int addComment(HmComment comment);

    void deleteComment(Long commentId);
}

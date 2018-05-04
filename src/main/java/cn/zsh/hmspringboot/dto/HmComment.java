package cn.zsh.hmspringboot.dto;

import javax.persistence.*;
import java.util.Date;

/**
 * @author kilodleif
 */
@Table(name = "hm_comment")
public class HmComment {

    @Id
    @Column
    @GeneratedValue(generator = "JDBC")
    private Long commentId;

    @Column
    private Long userId;

    @Transient
    private String account;

    @Column
    private String content;

    @Column
    private Date createTime;

    public Long getCommentId() {
        return commentId;
    }

    public void setCommentId(Long commentId) {
        this.commentId = commentId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}

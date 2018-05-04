package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmUser;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmUserService {

    boolean authenticate(String account, String password);

    HmUser getUser(String account);

    boolean checkUsed(String account);

    void register(HmUser user);

    int updateUser(HmUser user);

    List<HmUser> query(HmUser condition, int page, int pageSize);

    void deleteUser(Long userId);

}

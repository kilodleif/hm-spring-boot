package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmUserInfo;

/**
 * @author kilodleif
 */
public interface IHmUserInfoService {

    int updateUserInfo(HmUserInfo userInfo);

    HmUserInfo getUserInfoByUserId(Long userId);

}

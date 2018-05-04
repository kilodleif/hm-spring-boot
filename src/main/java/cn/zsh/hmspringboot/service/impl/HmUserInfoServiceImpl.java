package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmUserInfo;
import cn.zsh.hmspringboot.mapper.HmUserInfoMapper;
import cn.zsh.hmspringboot.service.IHmUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author kilodleif
 */
@Service
public class HmUserInfoServiceImpl implements IHmUserInfoService {

    @Autowired
    HmUserInfoMapper mapper;

    @Override
    public int updateUserInfo(HmUserInfo userInfo) {
        HmUserInfo toUpdate = mapper.selectOne(new HmUserInfo(userInfo.getUserId()));
        toUpdate.setName(userInfo.getName());
        toUpdate.setGender(userInfo.getGender());
        toUpdate.setTelephone(userInfo.getTelephone());
        toUpdate.setEmail(userInfo.getEmail());
        toUpdate.setAddress(userInfo.getAddress());
        return mapper.updateByPrimaryKeySelective(toUpdate);
    }

    @Override
    public HmUserInfo getUserInfoByUserId(Long userId) {
        return mapper.selectOne(new HmUserInfo(userId));
    }
}

package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmUser;
import cn.zsh.hmspringboot.dto.HmUserInfo;
import cn.zsh.hmspringboot.mapper.HmUserInfoMapper;
import cn.zsh.hmspringboot.mapper.HmUserMapper;
import cn.zsh.hmspringboot.service.IHmUserService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmUserServiceImpl implements IHmUserService {

    @Autowired
    private HmUserMapper userMapper;

    @Autowired
    private HmUserInfoMapper userInfoMapper;

    @Override
    public boolean authenticate(String account, String password) {
        if (account == null || password == null) {
            return false;
        }
        HmUser condition = new HmUser();
        condition.setAccount(account);
        condition.setPassword(password);
        return userMapper.select(condition).size() > 0;
    }

    @Override
    public HmUser getUser(String account) {
        return userMapper.listUserAndInfo(new HmUser(account)).get(0);
    }

    @Override
    public boolean checkUsed(String account) {
        return userMapper.listUserAndInfo(new HmUser(account)).size() == 0;
    }

    @Override
    public void register(HmUser user) {
        userMapper.insertSelective(user);
        HmUserInfo userInfo = new HmUserInfo();
        userInfo.setUserId(user.getUserId());
        userInfo.setName(user.getName());
        userInfo.setGender(user.getGender());
        userInfo.setTelephone(user.getTelephone());
        userInfo.setEmail(user.getEmail());
        userInfo.setAddress(user.getAddress());
        userInfoMapper.insertSelective(userInfo);
    }

    @Override
    public int updateUser(HmUser user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public List<HmUser> query(HmUser condition, int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        condition.setUserType("USER");
        return userMapper.listUserAndInfo(condition);
    }

    @Override
    public void deleteUser(Long userId) {
        if (userId != null) {
            userMapper.deleteByPrimaryKey(userId);
            userInfoMapper.delete(new HmUserInfo(userId));
        }
    }
}

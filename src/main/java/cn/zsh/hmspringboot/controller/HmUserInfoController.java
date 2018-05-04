package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmUserInfo;
import cn.zsh.hmspringboot.service.IHmUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("userInfo")
public class HmUserInfoController {

    @Autowired
    IHmUserInfoService service;

    @RequestMapping(value = "/update")
    @ResponseBody
    public boolean update(HmUserInfo userInfo) {
        return service.updateUserInfo(userInfo) > 0;
    }

    @RequestMapping(value = "/fetch")
    @ResponseBody
    public HmUserInfo fetch(Long userId) {
        return service.getUserInfoByUserId(userId);
    }
}

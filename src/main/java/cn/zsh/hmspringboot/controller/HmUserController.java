package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmUser;
import cn.zsh.hmspringboot.service.IHmUserService;
import cn.zsh.hmspringboot.util.ReturnData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("user")
public class HmUserController {

    @Autowired
    IHmUserService service;

    /**
     * 登录验证
     */
    @RequestMapping("/auth")
    @ResponseBody
    public boolean auth(String account, String password, HttpSession session) {
        boolean flag = service.authenticate(account, password);
        if (flag) {
            session.setAttribute("_operator", service.getUser(account));
        }
        return flag;
    }

    /**
     * 登出
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.setAttribute("_operator", null);
        return "redirect:login";
    }

    /**
     * 检查账号是否存在
     */
    @RequestMapping("/checkUsed")
    @ResponseBody
    public boolean checkUsed(String account) {
        return service.checkUsed(account);
    }

    /**
     * 用户注册
     */
    @RequestMapping("/register")
    @ResponseBody
    public boolean register(HmUser user, HttpSession session) {
        service.register(user);
        session.setAttribute("_operator", user);
        return true;
    }

    /**
     * 修改密码
     */
    @RequestMapping("/alterPassword")
    @ResponseBody
    public boolean alterPassword(String password, HttpSession session) {
        HmUser user = new HmUser();
        user.setUserId(((HmUser) session.getAttribute("_operator")).getUserId());
        user.setPassword(password);
        return service.updateUser(user) > 0;
    }

    @RequestMapping(value = "/query")
    @ResponseBody
    public ReturnData query(HmUser condition, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) {
        return new ReturnData(service.query(condition, page, pageSize));
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public boolean delete(@RequestBody HmUser user) {
        service.deleteUser(user.getUserId());
        return true;
    }

}

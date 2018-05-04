package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.mapper.HmCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author kilodleif
 * @date 2018/5/3 上午12:50
 */
@Controller
public class HelloController {

    @Autowired
    HmCommentMapper commentMapper;

    @RequestMapping("/hello")
    public String sayHello(Model model) {
        model.addAttribute("username", "苟利国家生死以");
        return "hello";
    }

    @RequestMapping("/login")
    public String loginPage(Model model) {
        return "login";
    }
}

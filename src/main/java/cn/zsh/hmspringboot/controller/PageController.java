package cn.zsh.hmspringboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("page")
public class PageController {

    @RequestMapping(value = "/login")
    public String login(){
        return "login";
    }

    @RequestMapping(value = "/index")
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/error")
    public String error() {
        return "error";
    }

    @RequestMapping(value = "/queryRoom")
    public String queryRoom() {
        return "query_room";
    }

    @RequestMapping(value = "/queryFood")
    public String queryFood() {
        return "query_food";
    }

    @RequestMapping(value = "/personalOrder")
    public String personalOrder() {
        return "personal_order";
    }

    @RequestMapping(value = "/comment")
    public String comment(@RequestParam(defaultValue = "1") int page) {
        return "/comment/fetchByPage?page=" + page;
    }

    @RequestMapping(value = "/orderOperation")
    public String orderOperation() {
        return "order_operation";
    }

    @RequestMapping(value = "/roomInfoMaintain")
    public String roomInfoMaintain() {
        return "room_info_maintain";
    }

    @RequestMapping(value = "/foodInfoMaintain")
    public String foodInfoMaintain() {
        return "food_info_maintain";
    }

    @RequestMapping(value = "/userManage")
    public String userManage() {
        return "user_manage";
    }

    @RequestMapping(value = "/commentManage")
    public String commentManage() {
        return "comment_manage";
    }
}

package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmRoom;
import cn.zsh.hmspringboot.service.IHmRoomService;
import cn.zsh.hmspringboot.util.ReturnData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("room")
public class HmRoomController {

    @Autowired
    private IHmRoomService service;

    @RequestMapping(value = "/queryFree")
    @ResponseBody
    public ReturnData queryFree(HmRoom condition, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) {
        return new ReturnData(service.queryFree(condition, page, pageSize));
    }

    @RequestMapping(value = "/queryAll")
    @ResponseBody
    public ReturnData queryAll() {
        return new ReturnData(service.queryAll());
    }

    @RequestMapping(value = "/query")
    @ResponseBody
    public ReturnData query(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) {
        return new ReturnData(service.query(page, pageSize));
    }

    @RequestMapping(value = "/add")
    @ResponseBody
    public boolean add(@RequestBody HmRoom room) {
        service.addRoom(room);
        return true;
    }

    @RequestMapping(value = "/update")
    @ResponseBody
    public boolean update(@RequestBody HmRoom room) {
        service.updateRoom(room);
        return true;
    }

}

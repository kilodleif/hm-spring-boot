package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmRoomOrder;
import cn.zsh.hmspringboot.service.IHmRoomOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("roomOrder")
public class HmRoomOrderController {

    @Autowired
    private IHmRoomOrderService service;

    @RequestMapping(value = "/submit")
    @ResponseBody
    public boolean submit(HmRoomOrder roomOrder) {
        return service.submitOrder(roomOrder) > 0;
    }

}

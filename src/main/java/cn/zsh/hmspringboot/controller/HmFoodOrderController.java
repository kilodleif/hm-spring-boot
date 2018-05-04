package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmFoodOrder;
import cn.zsh.hmspringboot.service.IHmFoodOrderService;
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
@RequestMapping("foodOrder")
public class HmFoodOrderController {

    @Autowired
    private IHmFoodOrderService service;

    @RequestMapping(value = "/submit")
    @ResponseBody
    public boolean submit(@RequestBody HmFoodOrder foodOrder) throws Exception {
        service.addFoodOrder(foodOrder);
        return true;
    }

    @RequestMapping(value = "/query")
    @ResponseBody
    public ReturnData query(HmFoodOrder condition, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) throws Exception {
        return new ReturnData(service.queryFoodOrder(condition, page, pageSize));
    }

    @RequestMapping(value = "/send")
    @ResponseBody
    public boolean send(HmFoodOrder order) throws Exception {
        service.sendFood(order);
        return true;
    }

}

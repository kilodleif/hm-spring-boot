package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmFood;
import cn.zsh.hmspringboot.service.IHmFoodService;
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
@RequestMapping("food")
public class HmFoodController {

    @Autowired
    private IHmFoodService service;

    @RequestMapping(value = "/queryAvailable")
    @ResponseBody
    public ReturnData queryAvailable(HmFood condition, @RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) {
        return new ReturnData(service.queryAvailableFood(condition, page, pageSize));
    }

    @RequestMapping(value = "/query")
    @ResponseBody
    public ReturnData queryAll(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "10") int pageSize) {
        return new ReturnData(service.queryAll(page, pageSize));
    }

    @RequestMapping(value = "/add")
    @ResponseBody
    public boolean add(@RequestBody HmFood food) {
        service.addFood(food);
        return true;
    }

    @RequestMapping(value = "/update")
    @ResponseBody
    public boolean update(@RequestBody HmFood food) {
        service.updateFood(food);
        return true;
    }

}

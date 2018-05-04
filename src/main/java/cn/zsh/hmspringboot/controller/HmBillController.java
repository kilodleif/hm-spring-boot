package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmBill;
import cn.zsh.hmspringboot.service.IHmBillService;
import cn.zsh.hmspringboot.util.ReturnData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("bill")
public class HmBillController {

    @Autowired
    private IHmBillService service;

    @RequestMapping(value = "/queryPersonalBill")
    @ResponseBody
    public ReturnData queryFree(HmBill condition) {
        if ("".equals(condition.getBillType())) {
            condition.setBillType(null);
        }
        return new ReturnData(service.queryPersonalBill(condition));
    }
}

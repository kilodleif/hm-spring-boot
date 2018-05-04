package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmBill;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmBillService {

    List<HmBill> queryPersonalBill(HmBill condition);

}

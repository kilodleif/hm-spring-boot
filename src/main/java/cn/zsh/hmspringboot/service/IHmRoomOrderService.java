package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmRoomOrder;

/**
 * @author kilodleif
 */
public interface IHmRoomOrderService {

    int submitOrder(HmRoomOrder roomOrder);
}

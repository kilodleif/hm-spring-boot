package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmBill;
import cn.zsh.hmspringboot.dto.HmRoom;
import cn.zsh.hmspringboot.dto.HmRoomOrder;
import cn.zsh.hmspringboot.mapper.HmBillMapper;
import cn.zsh.hmspringboot.mapper.HmRoomMapper;
import cn.zsh.hmspringboot.mapper.HmRoomOrderMapper;
import cn.zsh.hmspringboot.service.IHmRoomOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;

/**
 * @author kilodleif
 */
@Service
public class HmRoomOrderServiceImpl implements IHmRoomOrderService {

    @Autowired
    private HmRoomOrderMapper roomOrderMapper;

    @Autowired
    private HmBillMapper billMapper;

    @Autowired
    private HmRoomMapper roomMapper;

    @Override
    public int submitOrder(HmRoomOrder roomOrder) {
        HmBill bill = new HmBill();
        bill.setUserId(roomOrder.getUserId());
        bill.setBillType("ROOM");
        //计算住房天数
        Calendar cal = Calendar.getInstance();
        cal.setTime(roomOrder.getCheckinTime());
        int inDay = cal.get(Calendar.DAY_OF_YEAR);
        cal.setTime(roomOrder.getCheckoutTime());
        int outDay = cal.get(Calendar.DAY_OF_YEAR);
        //获得房间信息
        HmRoom room = roomMapper.selectByPrimaryKey(roomOrder.getRoomId());
        //设置账单总额
        bill.setTotalPrice(room.getRoomPrice() * (outDay - inDay + 1));
        billMapper.insertSelective(bill);
        return roomOrderMapper.insertSelective(roomOrder);
    }
}

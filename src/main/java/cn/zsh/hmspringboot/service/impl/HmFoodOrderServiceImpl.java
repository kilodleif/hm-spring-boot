package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmBill;
import cn.zsh.hmspringboot.dto.HmFood;
import cn.zsh.hmspringboot.dto.HmFoodOrder;
import cn.zsh.hmspringboot.dto.HmFoodOrderDetail;
import cn.zsh.hmspringboot.mapper.HmBillMapper;
import cn.zsh.hmspringboot.mapper.HmFoodMapper;
import cn.zsh.hmspringboot.mapper.HmFoodOrderDetailMapper;
import cn.zsh.hmspringboot.mapper.HmFoodOrderMapper;
import cn.zsh.hmspringboot.service.IHmFoodOrderService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmFoodOrderServiceImpl implements IHmFoodOrderService {

    @Autowired
    private HmFoodOrderMapper foodOrderMapper;

    @Autowired
    private HmFoodOrderDetailMapper foodOrderDetailMapper;

    @Autowired
    private HmFoodMapper foodMapper;

    @Autowired
    private HmBillMapper billMapper;

    @Override
    public void addFoodOrder(HmFoodOrder foodOrder) {
        //插入菜肴订单表
        foodOrderMapper.insertSelective(foodOrder);
        Long orderId = foodOrder.getOrderId();
        //插入菜肴订单详情表
        for (HmFoodOrderDetail od : foodOrder.getOrderDetails()) {
            od.setOrderId(orderId);
            foodOrderDetailMapper.insertSelective(od);
            //更新菜肴信息表
            HmFood food = foodMapper.selectByPrimaryKey(od.getFoodId());
            food.setLeftAmount(food.getLeftAmount() - od.getAmount());
            foodMapper.updateByPrimaryKeySelective(food);
        }
        //插入账单
        HmBill bill = new HmBill();
        bill.setBillType("FOOD");
        bill.setUserId(foodOrder.getUserId());
        bill.setTotalPrice(foodOrder.getTotalPrice());
        billMapper.insertSelective(bill);
    }

    @Override
    public List<HmFoodOrder> queryFoodOrder(HmFoodOrder condition, int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        List<HmFoodOrder> list = foodOrderMapper.selectFoodOrderWithDetail(condition);
        for (HmFoodOrder fo : list) {
            HmFoodOrderDetail con = new HmFoodOrderDetail();
            con.setOrderId(fo.getOrderId());
            List<HmFoodOrderDetail> fods = foodOrderDetailMapper.selectWithFoodName(fo.getOrderId());
            Float total = 0F;
            for (HmFoodOrderDetail fod : fods) {
                total += fod.getAmount() * fod.getFood().getFoodPrice();
            }
            fo.setOrderDetails(fods);
            fo.setTotalPrice(total);
        }
        return list;
    }

    @Override
    public void sendFood(HmFoodOrder order) {
        order.setHandleTime(new Date());
        order.setOrderStatus("HANDLED");
        foodOrderMapper.updateByPrimaryKeySelective(order);
    }
}

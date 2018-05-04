package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmBill;
import cn.zsh.hmspringboot.mapper.HmBillMapper;
import cn.zsh.hmspringboot.service.IHmBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmBillServiceImpl implements IHmBillService {

    @Autowired
    private HmBillMapper mapper;

    @Override
    public List<HmBill> queryPersonalBill(HmBill condition) {
        return mapper.select(condition);
    }
}

package cn.zsh.hmspringboot.service.impl;

import cn.zsh.hmspringboot.dto.HmRoom;
import cn.zsh.hmspringboot.mapper.HmRoomMapper;
import cn.zsh.hmspringboot.service.IHmRoomService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kilodleif
 */
@Service
public class HmRoomServiceImpl implements IHmRoomService {

    @Autowired
    private HmRoomMapper mapper;

    @Override
    public List<HmRoom> queryFree(HmRoom condition, int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        return mapper.selectFree(condition);
    }

    @Override
    public List<HmRoom> query(int page, int pageSize) {
        PageHelper.startPage(page, pageSize);
        return mapper.select(new HmRoom());
    }

    @Override
    public List<HmRoom> queryAll() {
        return mapper.select(new HmRoom());
    }

    @Override
    public void addRoom(HmRoom room) {
        mapper.insertSelective(room);
    }

    @Override
    public void updateRoom(HmRoom room) {
        mapper.updateByPrimaryKeySelective(room);
    }
}

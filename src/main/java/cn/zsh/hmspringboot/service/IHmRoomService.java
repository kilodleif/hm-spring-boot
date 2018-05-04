package cn.zsh.hmspringboot.service;

import cn.zsh.hmspringboot.dto.HmRoom;

import java.util.List;

/**
 * @author kilodleif
 */
public interface IHmRoomService {

    List<HmRoom> query(int page, int pageSize);

    List<HmRoom> queryAll();

    List<HmRoom> queryFree(HmRoom condition, int page, int pageSize);

    void addRoom(HmRoom room);

    void updateRoom(HmRoom room);
}

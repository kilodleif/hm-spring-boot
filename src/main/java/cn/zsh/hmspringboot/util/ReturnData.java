package cn.zsh.hmspringboot.util;

import com.github.pagehelper.Page;

import java.util.List;

/**
 * @author kilodleif
 */
public class ReturnData {
    private List<?> data;
    private Long total;
    private Integer page;
    private Integer totalPage;

    public ReturnData() {
    }

    public ReturnData(List<?> data) {
        this.data = data;
        if (data instanceof Page) {
            setTotal(((Page<?>) data).getTotal());
            setPage(((Page<?>) data).getPageNum());
            setTotalPage(((Page<?>) data).getPages());
        } else {
            setTotal((long) data.size());
        }
    }

    public List<?> getData() {
        return data;
    }

    public void setData(List<?> data) {
        this.data = data;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }
}

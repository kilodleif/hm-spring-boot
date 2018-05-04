package cn.zsh.hmspringboot.controller;

import cn.zsh.hmspringboot.dto.HmComment;
import cn.zsh.hmspringboot.dto.HmUser;
import cn.zsh.hmspringboot.service.IHmCommentService;
import cn.zsh.hmspringboot.util.ReturnData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author kilodleif
 */
@Controller
@RequestMapping("comment")
public class HmCommentController {

    @Autowired
    private IHmCommentService service;

    @RequestMapping(value = "/fetchByPage")
    public String fetchCommentByPage(int page, Model model, HttpServletRequest request) throws Exception {
        ReturnData rd = new ReturnData(service.getAllCommentByPage(page));
        model.addAttribute("returnData", rd);
        return "comment";
    }

    @RequestMapping(value = "/submit")
    @ResponseBody
    public boolean submit(String content, HttpSession session) throws Exception {
        HmComment comment = new HmComment();
        comment.setUserId(((HmUser) session.getAttribute("_operator")).getUserId());
        comment.setContent(content);
        return service.addComment(comment) > 0;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public boolean update(Long commentId) throws Exception {
        service.deleteComment(commentId);
        return true;
    }

}

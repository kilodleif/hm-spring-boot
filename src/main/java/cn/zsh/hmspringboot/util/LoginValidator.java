package cn.zsh.hmspringboot.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author kilodleif
 */
public class LoginValidator implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String reqUrl = request.getRequestURI();

        //当url地址为登录验证、检查账号重复和注册的url时跳过拦截器 静态资源文件跳过拦截器
        if (!(reqUrl.contains("auth") ||
                reqUrl.contains("checkUsed") ||
                reqUrl.contains("register") ||
                reqUrl.contains("/page/login") ||
                reqUrl.contains("resource/")
        )) {
            HttpSession session = request.getSession();
            Object obj = session.getAttribute("_operator");
            //当session中没有登录用户时拦截该请求
            if (obj == null) {
                response.sendRedirect(request.getContextPath() + "/page/login");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}

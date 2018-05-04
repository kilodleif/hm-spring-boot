package cn.zsh.hmspringboot.config;

import cn.zsh.hmspringboot.util.LoginValidator;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author kilodleif
 * @date 2018/5/4 上午11:43
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 增加登录验证拦截器
        registry.addInterceptor(new LoginValidator());
    }
}

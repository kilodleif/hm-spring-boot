package cn.zsh.hmspringboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author kilodleif
 */
@SpringBootApplication
@tk.mybatis.spring.annotation.MapperScan(basePackages = "cn.zsh.hmspringboot.mapper")
public class HmSpringBootApplication {

    public static void main(String[] args) {
        SpringApplication.run(HmSpringBootApplication.class, args);
    }
}

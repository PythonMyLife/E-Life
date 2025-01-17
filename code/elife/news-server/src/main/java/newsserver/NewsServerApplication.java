package newsserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@EnableEurekaClient
@RestController
/**
 * @Author wyx
 * @Data 2019.07.09
 */
public class NewsServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(NewsServerApplication.class, args);
    }

}

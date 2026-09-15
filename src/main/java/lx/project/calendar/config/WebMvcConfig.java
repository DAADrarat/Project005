package lx.project.calendar.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import lx.project.calendar.interceptor.LoginInterceptor;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = { "lx.project.calendar" }) // 패키지 스캔 지정
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/"); // 끝에 '/' 확인
        resolver.setSuffix(".jsp");
        return resolver;
    } 

    // 컨트롤러 클래스 없이 URL 요청을 JSP로 직접 연결
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("home");     // http://localhost:8080/myabwebconfig/ -> home.jsp
        registry.addViewController("/home").setViewName("home"); // http://localhost:8080/myabwebconfig/home -> home.jsp
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/list.do")     // 기존 보호 경로
                .addPathPatterns("/myPage.do");  // [추가] 마이페이지 접근 시 로그인 필수!

           }
    
    // css적용하는거
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
                registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
    }
}
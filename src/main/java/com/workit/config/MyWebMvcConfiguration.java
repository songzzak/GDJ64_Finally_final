package com.workit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;

@Configuration
@EnableWebSocket
public class MyWebMvcConfiguration implements WebMvcConfigurer{

	//view설정
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
		registry.addViewController("/notice").setViewName("/board/noticeView");
		registry.addViewController("/insertnotice").setViewName("/board/insertNotice");
		registry.addViewController("/editor").setViewName("/smarteditor/newPost");
	}

}

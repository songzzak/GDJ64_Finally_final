package com.workit.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsUtils;

import com.workit.member.model.dto.MemberAuthority;
@Configuration //config 클래스로 등록
@EnableWebSecurity //security 설정
public class SecurityConfig {
	@Bean
	public SecurityFilterChain authenticationPath(HttpSecurity http) throws Exception{
		return http.csrf().disable()
				.formLogin()
					.successForwardUrl("/successLogin")
					.failureForwardUrl("/errorLogin")
					.passwordParameter("pw")
					.loginProcessingUrl("/login.do")
					.loginPage("/loginpage")
				.and()
				.authorizeHttpRequests() //interceptor를 등록하는 것과 같은 기능
					.requestMatchers(CorsUtils::isPreFlightRequest).permitAll()
					.antMatchers("/loginpage").permitAll()
					.antMatchers("/errorLogin").permitAll()
					.antMatchers("/firstLogin").hasAnyAuthority(MemberAuthority.MEMBER.name())
				.and()
				.logout()
					.logoutSuccessUrl("/logout")
					.logoutUrl("/logout.do")
				.and()
				//.authenticationProvider(provider)
				.build();
	}
}

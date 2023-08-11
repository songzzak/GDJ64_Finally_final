package com.workit.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.cors.CorsUtils;

import com.workit.member.model.dto.MemberAuthority;
@Configuration
@EnableWebSecurity
public class SecurityConfig{
	@Autowired
	private DBConnectProvider provider;
	
	@Bean
	public SecurityFilterChain authenticationPath(HttpSecurity http) throws Exception{
		return http.csrf().disable()
				.formLogin()
					.successForwardUrl("/login/success")
					.failureForwardUrl("/login/fail")
					.passwordParameter("password")
					.usernameParameter("memberId")
					.loginProcessingUrl("/login")
					.loginPage("/loginpage")
				.and()
				.authorizeHttpRequests()
					.requestMatchers(CorsUtils::isPreFlightRequest).permitAll()
					.antMatchers("/login/**").permitAll()
					.antMatchers("/error/**").permitAll()
					.antMatchers("/loginpage").permitAll()
					.antMatchers("/logout").permitAll()
					.antMatchers("/resources/**").permitAll()
					.antMatchers("/**").hasAnyAuthority(MemberAuthority.EMP.name())
					.antMatchers("/firstLogin").hasAnyAuthority(MemberAuthority.EMP.name())
					.antMatchers("/employee/**").hasAnyAuthority(MemberAuthority.DEPT_EMP.name())
					.antMatchers("/employee/enroll").hasAnyAuthority(MemberAuthority.TEAMMASTER.name())
					.antMatchers("/employee/job").hasAnyAuthority(MemberAuthority.SUBMASTER.name(), MemberAuthority.MASTER.name())
				.and()
				.logout()
					.logoutSuccessUrl("/loginpage")
					.logoutUrl("/logout")
					.invalidateHttpSession(true).deleteCookies("JSESSIONID")
				.and()
				.exceptionHandling()
					.authenticationEntryPoint(new AuthenticationEntryPoint() {
						@Override
						public void commence(HttpServletRequest request, HttpServletResponse response,
								AuthenticationException authException) throws IOException, ServletException {
							response.sendRedirect("/error/login");
						}
					}).accessDeniedHandler(new AccessDeniedHandler() {
						@Override
						public void handle(HttpServletRequest request, HttpServletResponse response,
								AccessDeniedException accessDeniedException) throws IOException, ServletException {
							response.sendRedirect("/error/auth");
						}
					})
				.and()
				.headers()
				.frameOptions().sameOrigin()
				.and()
				.authenticationProvider(provider)
				.build();
	}
}

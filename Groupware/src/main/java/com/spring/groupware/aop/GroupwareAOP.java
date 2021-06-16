package com.spring.groupware.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.groupware.common.MyUtil;

@Aspect
@Component
public class GroupwareAOP {

	// == Pointcut (주업무) 설정 == //
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..))")
	public void requiredLogin() {
	}

	// == Before Advice (공통업무) 구현 == //

	// 로그인 유무 검사하는 메소드
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinPoint) {

		HttpServletRequest request = (HttpServletRequest) joinPoint.getArgs()[0]; // 주업무 메소드의 첫번째 파라미터를 얻어오기
		HttpServletResponse response = (HttpServletResponse) joinPoint.getArgs()[1]; // 주업무 메소드의 두번째 파라미터를 얻어오기

		// 로그인 유무를 확인하기 위해 session 가져오기
		HttpSession session = request.getSession();
		

		if (session.getAttribute("loginuser") == null) {
			String message = "먼저 로그인 하세요~~~";
			String loc = request.getContextPath() + "/login.opis";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// 로그인 성공 후 로그인 하기전 페이지로 돌아가기 위한 작업
			String url = MyUtil.getCurrentURL(request); // 현재 페이지 주소(URL) 알아오기
//			System.out.println("~~~확인용 url => "+ url);

			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장
			

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
}
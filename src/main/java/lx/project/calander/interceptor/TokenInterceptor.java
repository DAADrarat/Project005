package lx.project.calander.interceptor;

import org.apache.catalina.connector.Response;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


// Controller가 실행되기 전에 사용자가 로그인했는지 확인하기
public class TokenInterceptor implements HandlerInterceptor{
	
	@Override
	//preHandle()은 Controller가 실행되기 전에 호출
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String sessionToken = (String) session.getAttribute("token");
		String reqToken = request.getParameter("token");
		System.out.printf("sessionToken=%s, reqToken=%s", sessionToken, reqToken);
		session.setAttribute("token", null);
		if(sessionToken!=null && reqToken != null && reqToken.equals(sessionToken)) {
			return true;
		}
		String contextPath = request.getContextPath();
		response.sendRedirect(contextPath + "/list.do");
		return false;
	}
	
	
}

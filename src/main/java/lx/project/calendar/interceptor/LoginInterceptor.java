package lx.project.calendar.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


// Controller가 실행되기 전에 사용자가 로그인했는지 확인하기
public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	//preHandle()은 Controller가 실행되기 전에 호출
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		Integer memberId = (Integer) session.getAttribute("memberId");
		System.out.println("session memberId=" + memberId);
		if(memberId != null && memberId > 0) {
			return true;
		}
		// 인터셉터에서 memberId가 null일 때 return false로 마무리되지 않고 redirect 되게 만듦
		response.sendRedirect(request.getContextPath() + "/login.do");
		return false;
	}
	
	
}
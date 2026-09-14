package lx.project.calander.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


// Controller가 실행되기 전에 사용자가 로그인했는지 확인하기
public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	//preHandle()은 Controller가 실행되기 전에 호출
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//현재 사용자 세션 가져오기
		HttpSession session = request.getSession();
		// 로그인할때 저장했던 id 세션 가져오기 session.setAttribute("id", id);랑 세트바뤼
		String id = (String) session.getAttribute("id");
		System.out.println("session id=" + id);
		if(id!=null && id.length()>0) {
			return true;
		}
		response.sendRedirect("loginform.do");
		//로그안 안돼있으면 컨트롤러 안보냄
		return false;
	}
	
	
}

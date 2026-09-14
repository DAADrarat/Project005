package lx.project.calander.contoller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginoutController {

	@RequestMapping("/loginform.do")
	public String loginForm() {
		return "login";
	}
	
	@RequestMapping("/login.do")
	public String login(
			//로그인 폼에서 보낸 값 String으로 받기
			@RequestParam("id") String id, 
			@RequestParam("pw") String pw, 
			HttpServletRequest req) {
		//id와 pw가 동일하다면 로그인된걸로 틀리다면 로그인을 다시하도록
		if(id!=null && id.equals(pw)) {
			//현재 사용자의 세션 가져오기
			HttpSession session = req.getSession();
			//세션에 로그인한 id 저장
			session.setAttribute("id", id);
			return "index";
		}
		return "login";
	}
	
	
}

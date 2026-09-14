package lx.project.calander.contoller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lx.project.calander.dao.ScheduleDAO;
import lx.project.calander.to.EmployTO;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequiredArgsConstructor

public class PageController {
	
	
	private final ScheduleDAO dao;
	private final LicenseDAO dao;
	
//		model의 매서드를 호출하고 결과를 request에 넣는다
	@RequestMapping("/list.do")
	public String list(HttpServletRequest req) {
		//login하지않았다면 loginform redirect한다
		List<EmployTO> list = dao.getList();
		req.setAttribute("data", list);
		return "addrbook_list";
	}
	
	@RequestMapping("/form.do")
	public ModelAndView form() {
		ModelAndView result = new ModelAndView();
		result.setViewName("addrbook_form");
		return result;
	}
	
	
	@RequestMapping(value = "/insert.do", method=RequestMethod.POST)
	public String insert(EmployTO to) {
//		String clientToken = req.getParameter("token");
//		String sessionToken = (String) session.getAttribute("token");
//		session.setAttribute("token", null);
//		if(!clientToken.equals(sessionToken)) {
//			//다른곳으로 포워딩 또는 리다이렉트한다.
//		}
		System.out.println(to);
		int result = dao.insert(to);
		System.out.println(result);
		return "redirect:list.do";
	}
	
	@RequestMapping("editform.do")
	public String editForm(@RequestParam("abId") int abId, HttpServletRequest request) {
		//요청에서 뭘? 방명록 아이디
		EmployTO ab = dao.getAddrById(abId);
		//여기에 넣어두면 jsp에서 꺼내간다
		request.setAttribute("ab", ab);
		return "addrbook_edit_form";
	}

	@RequestMapping("edit.do")
	public String edit(EmployTO to) {
		//클라이언트에서 수정해서 전송한 방명록 정보를 꺼내온다
		System.out.println(to);
		// 가져왔으니까 다오에 있는 업데이트 함수 호출
		dao.update(to);
		return "redirect:list.do";
	}
	
	@RequestMapping(value = "/edit.do", method=RequestMethod.POST, params="action=delete")
	public String delete(EmployTO to) {
		System.out.println(to);
		int result = dao.delete(to);
		System.out.println(result);
		return "redirect:list.do";
	}
	
	
}

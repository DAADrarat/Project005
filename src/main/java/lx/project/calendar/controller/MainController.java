package lx.project.calendar.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lx.project.calendar.dao.MyPageDAO;
import lx.project.calendar.service.MemberService;
import lx.project.calendar.to.CertExamTO;
import lx.project.calendar.to.CertTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.JobAppHistoryTO;
import lx.project.calendar.to.MemberTO;
import lx.project.calendar.to.RecruitmentTO;
import lx.project.calendar.to.ScheduleTO;
import lx.project.calendar.service.MyPageService;
import lx.project.calendar.service.ScheduleService;

@Controller
@RequiredArgsConstructor
public class MainController {

	@Autowired
	@Qualifier("MemberServiceImpl")
	private MemberService service;

	@Autowired
	@Qualifier("MyPageServiceImpl")
	private MyPageService myPageService;

	@Autowired
	@Qualifier("ScheduleServiceImpl")
	private ScheduleService scheduleService;

	@RequestMapping("/main.do")
	public String home() {
		return "main";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {
		return "login";
	}


	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:/main.do";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String logincheck(@RequestParam("userId") String userId, @RequestParam("password") String password,
			HttpServletRequest req) {
		int logincheck = service.loginCheck(userId, password);
		if (logincheck > 0) {
			HttpSession session = req.getSession();
			session.setAttribute("userId", userId);
			session.setAttribute("password", password);
			session.setAttribute("memberId", logincheck);
			return "redirect:/main.do";
		}
		return "redirect:/login.do";
	}

	@RequestMapping("signUp.do")
	public String signUp() {
		return "signUp";
	}

	@RequestMapping(value = "/signUpProc.do", method = RequestMethod.POST)
	public String signUpProc(MemberTO member) {

		boolean isSuccess = service.signUpMember(member);

		if (isSuccess) {
			return "redirect:/login.do";
		} else {
			return "redirect:/signUp.do";
		}
	}

	@RequestMapping("/edit.do")
	public String edit(HttpSession session, HttpServletRequest req) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		MemberTO member = service.selectOne(memberId);
		req.setAttribute("member", member);
		return "edit";
	}

	@RequestMapping(value = "/edit.do", method = RequestMethod.POST)
	public String editaction(HttpSession session, MemberTO member) {
		Integer memberId = (Integer) session.getAttribute("memberId");

		if (memberId == null || memberId == 0) {
			return "redirect:/login.do";
		}
		// 세션의 memberId를 set하여 본인 계정이 수정되도록 보장
		member.setMemberId(memberId);

		MemberTO newmember = service.updateMember(member);

		if (newmember != null) {
			session.setAttribute("member", newmember);
			return "myPage";
		} else {
			return "redirect:/login.do";
		}
	}

	// 탈퇴 jsp에서 버튼 눌렀을 때 액션 removeAction.do로 바꾸기
	@RequestMapping("/remove.do")
	public String remove() {
		return "remove";
	}

	@RequestMapping("/removeAction.do")
	public String removeAction(HttpSession session) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		service.removeAction(memberId);
		session.invalidate();
		return "redirect:/main.do";
	}

	// 뱃지달기
	@RequestMapping("/badge.do")
	public String possession() {
		return "badge";
	}

	// 뱃지달기2
	@RequestMapping(value = "/saveCerts.do", method = RequestMethod.POST)
	public String saveCerts(@RequestParam(value = "certCodes", required = false) List<String> certCodes,
			HttpSession session) {

		if (certCodes != null && !certCodes.isEmpty()) {
			List<CertTO> certList = service.getCertsByCodes(certCodes);
			session.setAttribute("myCerts", certList);
		} else {
			session.removeAttribute("myCerts");
		}

		return "redirect:/badge.do";
	}

	@RequestMapping("/myPage.do")
	public String myPage(HttpSession session, Model model) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		if (memberId != null && memberId > 0) {
			model.addAttribute("events", myPageService.getMySchedule(memberId));
			return "myPage";

		}
		return "redirect:/login.do";
		// 내가 신청한 정책+자격증+채용이 한 목록으로 들어옴 (allpcj 로 종류 구분)
	}

	// 전체일정
	@RequestMapping("/calendarAll.do")
	public String calendarAll(Model model) {
		model.addAttribute("events", scheduleService.getAllSchedules());
		return "calendarAll";
	}

	// 정부사업일정
	@RequestMapping("/calendarPolicy.do")
	public String calendarPolicy(Model model) {
		model.addAttribute("events", scheduleService.getSchedulesByType("POLICY"));
		model.addAttribute("policyList", scheduleService.getPolicyList());
		return "calendarPolicy";
	}

	@RequestMapping("/calendarCertification.do")
	public String calendarCertification(Model model) {
		model.addAttribute("events", scheduleService.getSchedulesByType("CERT"));
		model.addAttribute("certExamList", scheduleService.getCertExamList());
		return "calendarCertification";
	}

	// 채용공고일정
	@RequestMapping("/calendarJob.do")
	public String calendarJob(Model model) {
		model.addAttribute("events", scheduleService.getSchedulesByType("JOB"));
		model.addAttribute("jobList", scheduleService.getJobList());
		return "calendarJob";
	}

	// 채용공고 신청
	@RequestMapping(value = "/applyJob.do", method = RequestMethod.POST)
	public String applyJob(@RequestParam(value = "jobPostingCode", required = false) List<String> codes,
			HttpSession session) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		if (memberId == null)
			return "redirect:/login.do";

		myPageService.applyJobs(memberId, codes);
		return "redirect:/myPage.do";
	}

	// 정부사업 신청
	@RequestMapping(value = "/applyPolicy.do", method = RequestMethod.POST)
	public String applyPolicy(@RequestParam(value = "govProjectCode", required = false) List<String> codes,
			HttpSession session) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		if (memberId == null)
			return "redirect:/login.do";
		myPageService.applyPolicies(memberId, codes);
		return "redirect:/myPage.do";
	}

	// 자격증시험 접수
	@RequestMapping(value = "/applyCert.do", method = RequestMethod.POST)
	public String applyCert(@RequestParam(value = "examSession", required = false) List<String> codes,
			HttpSession session) {
		Integer memberId = (Integer) session.getAttribute("memberId");
		if (memberId == null)
			return "redirect:/login.do";
		myPageService.applyCerts(memberId, codes);
		return "redirect:/myPage.do";
	}

	// 취소버튼
	@RequestMapping(value = "/cancelApply.do", method = RequestMethod.POST)
	public String cancelApply(@RequestParam("type") String type, @RequestParam("appId") String appId) {
		myPageService.cancelApply(type, appId);
		return "redirect:/myPage.do";
	}
	//ajax 검색을 위한
	@RequestMapping("/searchCert.do")
	@ResponseBody                                   // ← 뷰가 아니라 데이터를 그대로 반환
	public List<CertExamTO> searchCert(
	        @RequestParam(value = "keyword", required = false) String keyword) {
	    return scheduleService.searchCert(keyword);
	}
	
	
	@RequestMapping("/searchPolicy.do")
	@ResponseBody
	public List<GovSupportPolicyTO> searchPolicy(
			@RequestParam(value = "keyword", required = false) String keyword) {
		return scheduleService.searchPolicy(keyword);
	}
	
	@RequestMapping("/searchJob.do")
	@ResponseBody
	public List<RecruitmentTO> searchJob(
			@RequestParam(value = "keyword", required = false) String keyword) {
		return scheduleService.searchJob(keyword);
	}
	
	@RequestMapping("/searchAll.do")
	@ResponseBody
	public List<ScheduleTO> searchAll(
			@RequestParam(value = "keyword", required = false) String keyword) {
		return scheduleService.searchAll(keyword);
	}
}
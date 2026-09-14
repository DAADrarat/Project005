package lx.project.calendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CalendarController {
	@GetMapping("/calendarAll.do")
	public String calendarAll() {
		return "calendarAll";
	}

	@GetMapping("/calendarPolicy.do")
	public String calendarPolicy() {
		return "calendarPolicy";
	}

	@GetMapping("/calendarCertification.do")
	public String calendarCertification() {
		return "calendarCertification";
	}

	@GetMapping("/calendarJob.do")
	public String calendarJob() {
		return "calendarJob";
	}
}

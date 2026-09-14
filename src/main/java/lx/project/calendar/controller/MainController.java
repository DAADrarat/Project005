package lx.project.calendar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

   
	@GetMapping("/main.do")
    public String home() {
        return "main"; 
    }

	@GetMapping("/login.do")
    public String login() {
        return "login"; 
    }
	
	@GetMapping("/myPage.do")
	public String myPage() {
		return "myPage";
	}
	
	
}
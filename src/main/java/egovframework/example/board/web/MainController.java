package egovframework.example.board.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping(value = "/main.do")
	public String getMainPage() {
		return "eGovBoard/main";
	}
	
	@RequestMapping(value = "/login.do")
	public String login() {
		return "redirect:/list.do";
	}
	
}
package egovframework.example.board.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.board.service.BoardService;

@Controller
public class MainController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value = "/main.do")
	public String getMainPage() {
		return "eGovBoard/main";
	}
	
	@RequestMapping(value = "/login.do")
	public String login() {
		return "redirect:/list.do";
	}
	
}
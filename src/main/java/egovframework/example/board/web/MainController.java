package egovframework.example.board.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

@Controller
public class MainController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value = "/loginForm.do")
	public String getMainPage() {
		return "eGovBoard/loginForm";
	}
	
	@RequestMapping(value = "/login.do")
	public String loginCheck(@ModelAttribute BoardVO bVO, HttpSession session) {
		
		BoardVO authUser = boardService.loginCheck(bVO);
		System.out.println("login : " + authUser);
		if(authUser != null) {
			session.setAttribute("authUser", authUser);
			return "redirect:/list.do";
		}else {
			return "redirect:/loginForm.do";
		}
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/loginForm.do";
	}
}
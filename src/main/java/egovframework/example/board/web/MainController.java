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
	
	@RequestMapping(value = "/main.do")
	public String getMainPage() {
		return "eGovBoard/main";
	}
	
	@RequestMapping(value = "/login.do")
	public String loginCheck(@ModelAttribute BoardVO bVO, HttpSession session) {
		
		BoardVO authUser = boardService.loginCheck(bVO);
		
		if(authUser != null) {
			session.setAttribute("authUserName", bVO.getUserName());
			session.setAttribute("authUserNo", bVO.getUserNo());
			return "eGovBoard/list";
		}else {
			return "redirect:/main.do";
		}
		
		
		
	}
	
}
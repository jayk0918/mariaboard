package egovframework.example.board.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

@Controller
public class MainController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@GetMapping(value = "/loginForm.do")
	public String getMainPage() {
		return "eGovBoard/loginForm";
	}
	
	@PostMapping(value = "/login.do")
	public String loginCheck(@ModelAttribute BoardVO bVO, HttpSession session) {
		
		// 입력한 id, pw값을 검증
		BoardVO authUser = boardService.loginCheck(bVO);
		
		// 검증된 유저면 해당 유저의 고유No를 세션에 authUser라 명명하여 저장
		// 아닐 경우 로그인 폼으로 회귀
		if(authUser != null) {
			session.setAttribute("authUser", authUser);
			return "redirect:/list.do";
		}else {
			return "redirect:/loginForm.do";
		}
	}
	
	//////// logout시 세션 값 제거 ////////
	@GetMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/loginForm.do";
	}
}
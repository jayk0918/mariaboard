package egovframework.example.board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value = "/list.do")
	public String getList(Model model, HttpSession session) throws Exception{
		
		System.out.println("db요청");
		BoardVO authUser = (BoardVO) session.getAttribute("authUser");
		
		List<BoardVO> list = boardService.selectBoardList();
		System.out.println("list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("authUser", authUser);
		
		return "eGovBoard/list";
	}
	
	@RequestMapping(value = "/writeForm.do")
	public String getWriteForm(Model model, HttpSession session) {
		
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		int userNo = vo.getUserNo();
		model.addAttribute("userNo", userNo);
		
		return "eGovBoard/writeForm";
	}
	
	@RequestMapping(value = "/write.do")
	public String writeContent(@ModelAttribute BoardVO bVO) throws Exception {
		
		boardService.insertContent(bVO);
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "/readContent.do")
	public String readContent() {
		return "eGovBoard/readContent";
	}
	
}
package egovframework.example.board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		String userName = vo.getUserName();
		System.out.println("print userName : " + userName);
		
		List<BoardVO> list = boardService.selectBoardList();
		System.out.println(list);
		
		model.addAttribute("list", list);
		model.addAttribute("userName", userName);
		
		return "eGovBoard/list";
	}
	
	@RequestMapping(value = "/writeForm.do")
	public String getWriteForm() {
		return "eGovBoard/writeForm";
	}
	
	@RequestMapping(value = "/readContent.do")
	public String readContent() {
		return "eGovBoard/readContent";
	}
	
}
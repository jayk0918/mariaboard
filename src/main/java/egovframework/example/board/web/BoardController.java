package egovframework.example.board.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.board.service.BoardService;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value = "/list.do")
	public String getList(Model model) throws Exception{
		/*
		System.out.println("db요청");
		List<?> list = boardService.selectBoardList(BoardVO vo);
		model.addAttribute("list", list);
		*/
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
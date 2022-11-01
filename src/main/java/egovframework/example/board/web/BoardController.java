package egovframework.example.board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value = "/list.do")
	public String getList(Model model, HttpSession session, @ModelAttribute BoardVO vo) throws Exception{
		
		BoardVO authUser = (BoardVO) session.getAttribute("authUser");
		
		List<BoardVO> list = boardService.selectBoardList(vo);
		
		int totalCnt = boardService.selectBoardListTotCnt(vo);
		int totalPage = (int) Math.ceil((double)totalCnt/10);
		
		System.out.println("list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("authUser", authUser);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("totalPage", totalPage);
		
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
	public String writeContent(@ModelAttribute BoardVO bVO, HttpSession session) throws Exception {
		
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		int userNo = vo.getUserNo();
		bVO.setUserNo(userNo);
		boardService.insertContent(bVO);
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "/readContent.do")
	public String readContent(@RequestParam int contentNo, Model model) throws Exception {

		boardService.updateHit(contentNo);
		BoardVO content = boardService.getContent(contentNo);
		model.addAttribute("content", content);
		
		return "eGovBoard/readContent";
	}
	
	@RequestMapping(value = "/editForm.do")
	public String getEditForm(@RequestParam int contentNo, Model model) {
		
		BoardVO content = boardService.getContent(contentNo);
		model.addAttribute("content", content);
		
		return "eGovBoard/editForm";
	}
	
	@RequestMapping(value = "/edit.do")
	public String editContent(@ModelAttribute BoardVO vo) throws Exception {
		boardService.updateContent(vo);
		return "redirect:/list.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete.do")
	public int deleteContent(@RequestBody String contentNo) throws Exception {
		return boardService.deleteContent(contentNo);
	}
	
	/*
	@ResponseBody
	@RequestMapping(value = "/edit.do")
	public int updateContent(@RequestBody String vo) throws Exception {
		System.out.println("print Vo : " + vo);
		//return boardService.updateContent(vo);
	}
	*/
	
	
}
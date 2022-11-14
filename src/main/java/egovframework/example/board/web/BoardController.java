package egovframework.example.board.web;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(value = "/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String getList(Model model, HttpSession session, @ModelAttribute BoardVO vo) throws Exception{
		
		BoardVO authUser = (BoardVO) session.getAttribute("authUser");
		
		BoardVO searchVO = new BoardVO();
		int beforeCategory = vo.getSearchCategory();
		String beforeKeyword = vo.getSearchKeyword();
		
		searchVO.setSearchedCategory(beforeCategory);
		searchVO.setSearchedKeyword(beforeKeyword);
		searchVO.setSearchStatus(1);
		
		System.out.println("beforeCategory : " + beforeCategory);
		System.out.println("beforeKeyword : " + beforeKeyword);
		
		int categoryCheck = searchVO.getSearchedCategory();
		String keywordCheck = searchVO.getSearchedKeyword();
		
		if(categoryCheck != 0 && keywordCheck != null) {
			vo.setSearchCategory(categoryCheck);
			vo.setSearchKeyword(keywordCheck);
		}
		
		/******* Pagination *******/
		/** EgovPropertyService.sample **/
		vo.setPageUnit(propertiesService.getInt("pageUnit"));
		vo.setPageSize(propertiesService.getInt("pageSize"));

		/******* pagination setting *******/
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageIndex());
		paginationInfo.setRecordCountPerPage(vo.getPageUnit());
		paginationInfo.setPageSize(vo.getPageSize());

		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int totCnt = boardService.selectBoardListTotCnt(vo);
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<BoardVO> list = boardService.selectBoardList(vo);
		
		System.out.println("list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("authUser", authUser);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", searchVO);
		
		return "eGovBoard/list";
	}
	
	@GetMapping(value = "/writeForm.do")
	public String getWriteForm(Model model, HttpSession session) {
		
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		int userNo = vo.getUserNo();
		model.addAttribute("userNo", userNo);
		
		return "eGovBoard/writeForm";
	}
	
	@PostMapping(value = "/write.do")
	public String writeContent(@ModelAttribute BoardVO bVO,
								HttpSession session,
								@RequestParam(value = "file", required = false) MultipartFile file) throws Exception {
		
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		int userNo = vo.getUserNo();
		bVO.setUserNo(userNo);
		boardService.insertContent(bVO);
		
		if(file.isEmpty() != true) {
			boardService.fileSave(bVO, file);
		}
		
		return "redirect:/list.do";
	}
	
	@GetMapping(value = "/readContent.do")
	public String readContent(@RequestParam int contentNo, Model model) throws Exception {

		boardService.updateHit(contentNo);
		BoardVO content = boardService.getContent(contentNo);
		model.addAttribute("content", content);
		
		return "eGovBoard/readContent";
	}
	
	@GetMapping(value = "/editForm.do")
	public String getEditForm(@RequestParam int contentNo, Model model) throws IOException {
		
		BoardVO content = boardService.getContent(contentNo);
		model.addAttribute("content", content);
		
		return "eGovBoard/editForm";
	}
	
	@PostMapping(value = "/edit.do")
	public String editContent(@ModelAttribute BoardVO vo,
							  @RequestParam(value = "file", required = false) MultipartFile file,
							  @RequestParam(value = "editIdentify", required = false) int identify) throws Exception {
		
		if(identify == 0) {
			boardService.updateContent(vo);	
		}else {
			boardService.updateContent(vo);
			
			String fileExist = vo.getSaveName();
			if(fileExist.equals("")) {
				fileExist = null;
			}
			
			if(fileExist != null) {
				if(file.isEmpty() != true) {
					boardService.updateFile(vo, file);
				}else {
					boardService.removeFile(vo);
				}
			}else {
				if(file.isEmpty() != true) {
					boardService.fileSave(vo, file);
				}
			}
		}
		
		return "redirect:/list.do";
	}
	
	@ResponseBody
	@PostMapping(value = "/api/delete.do")
	public int deleteContent(@RequestBody String contentNo) throws Exception {
		boardService.deleteFile(contentNo);
		return boardService.deleteContent(contentNo);
	}
	
	@ResponseBody
	@PostMapping(value = "/api/list.do")
	public List<BoardVO> getReplyList(@RequestBody String contentNo){
		List<BoardVO> replies = boardService.getReplyList(contentNo);
		System.out.println("replies : " + replies);
		return replies;
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
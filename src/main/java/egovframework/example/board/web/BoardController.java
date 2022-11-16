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
	
	/** EgovPropertyService(페이징) */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	// 게시글 리스트 호출
	@RequestMapping(value = "/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String getList(Model model, HttpSession session, @ModelAttribute BoardVO vo) throws Exception{
		
		//////////// 로그인 신원 확인용 세션값 호출 ////////////
		BoardVO authUser = (BoardVO) session.getAttribute("authUser");
		
		//////////// 검색 business logic ////////////
		// 새로운 BoardVO 객체를 선언하여 해당 객체에 검색되었던 카테고리 및 키워드를 저장함 //
		BoardVO searchVO = new BoardVO();
		int beforeCategory = vo.getSearchCategory();
		String beforeKeyword = vo.getSearchKeyword();
		
		searchVO.setSearchedCategory(beforeCategory);
		searchVO.setSearchedKeyword(beforeKeyword);
		
		// 검색되었던 카테고리와 키워드를 검증하여 기존에 검색되었떤 값이 존재한다면 검색 키워드로 재설정 (페이징 시 검색값 유지) //
		int categoryCheck = searchVO.getSearchedCategory();
		String keywordCheck = searchVO.getSearchedKeyword();
		
		if(categoryCheck != 0 && keywordCheck != null) {
			vo.setSearchCategory(categoryCheck);
			vo.setSearchKeyword(keywordCheck);
		}
		
		//////////// 전자정부 프레임워크 제공 페이징 라이브러리 ////////////
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
		////////////////////////////////////////////////////////////
		
		// 검색 및 페이징 관련한 일련의 설정이 끝난 후 전체 리스트 또는 조건에 맞는 리스트를 호출함 //
		List<BoardVO> list = boardService.selectBoardList(vo);
		
		// model에 jsp태그에 필요한 데이터를 저장함 //
		model.addAttribute("list", list);
		model.addAttribute("authUser", authUser);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", searchVO);
		
		return "eGovBoard/list";
	}
	
	// 게시글 등록 폼 호출
	@GetMapping(value = "/writeForm.do")
	public String getWriteForm() {
		return "eGovBoard/writeForm";
	}
	
	// 게시글 등록
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
	public String readContent(HttpSession session, @RequestParam int contentNo, Model model) throws Exception {
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		boardService.updateHit(contentNo);
		BoardVO content = boardService.getContent(contentNo);
		model.addAttribute("content", content);
		model.addAttribute("authUser", vo);
		
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
	@PostMapping(value = "/api/replylist.do")
	public List<BoardVO> getReplyList(@RequestBody String contentNo){
		List<BoardVO> replies = boardService.getReplyList(contentNo);
		System.out.println("replies : " + replies);
		return replies;
	}
	
	
	@ResponseBody
	@PostMapping(value = "/api/replyAdd.do")
	public int insertReply(@RequestBody BoardVO vo) {
		return boardService.insertReply(vo);
	}
	
	@ResponseBody
	@PostMapping(value = "/api/replyDelete.do")
	public int deleteReply(@RequestBody String replyNo) {
		return boardService.deleteReply(replyNo);
	}
	
	@ResponseBody
	@PostMapping(value = "/api/verifyUser.do")
	public int verifyUser(@RequestBody BoardVO vo) {
		int result = boardService.verifyUser(vo);
		System.out.println("print result : " + result);
		return result;
	}
	
}
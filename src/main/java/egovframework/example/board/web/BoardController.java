package egovframework.example.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
		////////////////////////////////////////////////////////
		
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
		
		// 세션에 저장된 사용자의 No를 set하여 게시글을 저장
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		int userNo = vo.getUserNo();
		bVO.setUserNo(userNo);
		boardService.insertContent(bVO);
		
		// 첨부파일의 경우 게시글 테이블에서 외래키를 주는 방식으로 설계하였음
		// 첨부파일이 null일 경우 해당 로직은 pass, 있을 경우 함께 등록함
		if(file.isEmpty() != true) {
			boardService.fileSave(bVO, file);
		}
		
		return "redirect:/list.do";
	}
	
	// 게시글 상세 조회
	@GetMapping(value = "/readContent.do")
	public String readContent(HttpSession session, @RequestParam int contentNo, Model model) throws Exception {
		BoardVO vo = (BoardVO) session.getAttribute("authUser");
		
		// 조회수 +1
		boardService.updateHit(contentNo);
		
		// 파라미터 contentNo에 맞는 게시글 조회 후 model에 저장
		BoardVO content = boardService.getContent(contentNo);
		
		String newLine = content.getContent().replace("\r\n", "<br>");
		content.setContent(newLine);
		
		model.addAttribute("content", content);
		model.addAttribute("authUser", vo);
		
		return "eGovBoard/readContent";
	}
	
	// 게시글 수정 폼 호출
	@GetMapping(value = "/editForm.do")
	public String getEditForm(@RequestParam int contentNo, Model model) throws IOException {
		
		// 기존에 작성된 내용도 조회하여 model에 저장
		BoardVO content = boardService.getContent(contentNo);

		model.addAttribute("content", content);
		
		return "eGovBoard/editForm";
	}
	
	// 파일 다운로드
	@RequestMapping(value = "/fileDownload.do")
	public void fileDownload(@RequestParam String saveName, HttpServletRequest request, HttpServletResponse response) {
		
        String realFilename="";
         
        try {
            String browser = request.getHeader("User-Agent"); 
            //파일 인코딩 
            if (browser.contains("MSIE") || browser.contains("Trident")
                    || browser.contains("Chrome")) {
            	saveName = URLEncoder.encode(saveName, "UTF-8").replaceAll("\\+",
                        "%20");
            } else {
            	saveName = new String(saveName.getBytes("UTF-8"), "ISO-8859-1");
            }
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        realFilename = "C:\\Users\\jespe\\Downloads\\boardfiles\\" + saveName;
        File file1 = new File(realFilename);
        if (!file1.exists()) {
            return ;
        }
		
		// 파일명 지정        
        response.setContentType("application/octer-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + saveName + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realFilename);
 
            int ncount = 0;
            byte[] bytes = new byte[1024];
 
            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (Exception e) {
            System.out.println("FileNotFoundException : " + e);
        }
	}
	
	// 게시글 수정
	@PostMapping(value = "/edit.do")
	public String editContent(@ModelAttribute BoardVO vo,
							  @RequestParam(value = "file", required = false) MultipartFile file,
							  @RequestParam(value = "editIdentify", required = false) int identify) throws Exception {
		
		/*
		 사용자의 선택에 따라 파일을 유지 / 수정 / 삭제 가능함
		 
		 editIdentify(jsp요소명) & identify 역할 : 수정 데이터에서 첨부파일이 있는지의 여부를 판별하기 위한 파라미터
		 
		 identify 값
		 	-1, 1 : 새로운 파일 업로드를 대비하여 input file 태그를 제공, update 시 파일 업데이트 진행 (수정 or 삭제)
		 			사용자가 '수정'버튼을 누른 상태에서 수정을 진행하면 기존 파일은 삭제됨
			 0 : 수정할 첨부파일이 없는 상태.
			 	 0인 상태에서 사용자가 별도의 파일 수정을 진행하지 않으면 기존 파일은 유지됨(null처리)
		*/ 
		
		if(identify == 0) {
			boardService.updateContent(vo);	
		}else {
			boardService.updateContent(vo);
			
			// 파일 존재 여부 체크
			// fileExist 변수로 기존 첨부파일 존재 여부를 판별하여 없을 경우 null로 처리
			String fileExist = vo.getSaveName();
			if(fileExist.equals("")) {
				fileExist = null;
			}
			
			// 기존 첨부파일이 존재 할 경우, update를 진행하기 전에 update를 할 file의 존재 여부를 isEmpty()로 판별
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
	
	// ajax 게시글 삭제
	@ResponseBody
	@PostMapping(value = "/api/delete.do")
	public int deleteContent(@RequestBody String contentNo) throws Exception {
		boardService.deleteFile(contentNo);
		return boardService.deleteContent(contentNo);
	}
	
	// ajax 댓글 리스트 호출
	@ResponseBody 
	@PostMapping(value = "/api/replylist.do")
	public List<BoardVO> getReplyList(@RequestBody String contentNo){
		return boardService.getReplyList(contentNo);
	}
	
	// ajax 댓글 추가
	@ResponseBody
	@PostMapping(value = "/api/replyAdd.do")
	public int insertReply(@RequestBody BoardVO vo) {
		return boardService.insertReply(vo);
	}
	
	// ajax 댓글 삭제
	@ResponseBody
	@PostMapping(value = "/api/replyDelete.do")
	public int deleteReply(@RequestBody String replyNo) {
		return boardService.deleteReply(replyNo);
	}
	
	// ajax 댓글 삭제 권한 조회
	@ResponseBody
	@PostMapping(value = "/api/verifyUser.do")
	public int verifyUser(@RequestBody BoardVO vo) {
		return boardService.verifyUser(vo);
	}
	
}
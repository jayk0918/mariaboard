package egovframework.example.board.service;

import egovframework.example.sample.service.SampleDefaultVO;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor // 기본생성자
@ToString(callSuper = false)
@EqualsAndHashCode(callSuper = false)
public class BoardVO extends SampleDefaultVO {
	
	private static final long serialVersionUID = 1L;

	// 로그인 id, password
	private String userId;
	private String password;
	
	// 게시글 리스트
	private String title;
	private String content;
	private int userNo;
	private String userName;
	private int contentNo;
	private String date;
	private int hit;
	
	////// 검색 조건 //////
	// 검색 시 파라미터
	private String searchKeyword;
	private int searchCategory;
	
	// 페이징 시 검색값 유지를 위한 파라미터
	private String searchedKeyword;
	private int searchedCategory;
	
	// 첨부파일
	private int filesNo;
	private String orgName;
	private String saveName;
	private String filePath;
	private long fileSize;
	
	// 이전, 다음글
	private int prePage;
	private int nextPage;
	
	// 댓글
	private String reply;
	private int replyNo;
	
}

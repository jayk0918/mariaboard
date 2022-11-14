package egovframework.example.board.service;

import egovframework.example.sample.service.SampleDefaultVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BoardVO extends SampleDefaultVO {
	/**
	 * 
	 */
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
	
	// 검색 조건
	private String searchKeyword;
	private int searchCategory;
	private String searchedKeyword;
	private int searchedCategory;
	private int searchStatus;
	
	// 첨부파일
	private int filesNo;
	private String orgName;
	private String saveName;
	private String filePath;
	private long fileSize;
	
	// 댓글
	private String reply;
	private int replyNo;

	public BoardVO() {}
	
}

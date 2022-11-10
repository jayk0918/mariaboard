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
	
	private String userId;
	private String password;
	
	private String title;
	private String content;
	private int userNo;
	private String userName;
	private int contentNo;
	private String date;
	private int hit;
	
	private String searchKeyword;
	private int searchCategory;
	private String searchedKeyword;
	private int searchedCategory;
	private int searchStatus;
	
	private int filesNo;
	private String orgName;
	private String saveName;
	private String filePath;
	private long fileSize;

	public BoardVO() {}
	
}

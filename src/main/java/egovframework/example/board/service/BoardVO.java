package egovframework.example.board.service;

import egovframework.example.sample.service.SampleDefaultVO;

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
	
	public BoardVO() {}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getContentNo() {
		return contentNo;
	}

	public void setContentNo(int contentNo) {
		this.contentNo = contentNo;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	

	public int getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(int searchCategory) {
		this.searchCategory = searchCategory;
	}
	
	public String getSearchedKeyword() {
		return searchedKeyword;
	}

	public void setSearchedKeyword(String searchedKeyword) {
		this.searchedKeyword = searchedKeyword;
	}

	public int getSearchedCategory() {
		return searchedCategory;
	}

	public void setSearchedCategory(int searchedCategory) {
		this.searchedCategory = searchedCategory;
	}
	
	@Override
	public String toString() {
		return "BoardVO [userId=" + userId + ", password=" + password + ", title=" + title + ", content=" + content
				+ ", userNo=" + userNo + ", userName=" + userName + ", contentNo=" + contentNo + ", date=" + date
				+ ", hit=" + hit + ", searchKeyword=" + searchKeyword + ", searchCategory=" + searchCategory + "]";
	}

}

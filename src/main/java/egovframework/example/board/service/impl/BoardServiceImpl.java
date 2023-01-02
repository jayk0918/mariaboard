/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.board.service.impl;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;

/**
 * @Class Name : EgovBoardServiceImpl.java
 * @Description : Board Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);

	/** BoardDAO */
	// TODO ibatis 사용
	// @Resource(name = "sampleDAO")
	// private BoardDAO sampleDAO;
	
	// TODO mybatis 사용
	@Resource(name="boardMapper")
	private BoardMapper boardDAO;

	/** ID Generation */
	//@Resource(name = "egovIdGnrService")
	//private EgovIdGnrService egovIdGnrService;

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 BoardVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public int insertContent(BoardVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		return boardDAO.insertContent(vo);
	}

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
	public int updateContent(BoardVO vo) throws Exception {
		return boardDAO.updateContent(vo);
	}

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
	public int deleteContent(String contentNo) throws Exception {
		int convertNo = Integer.parseInt(contentNo);
		return boardDAO.deleteContent(convertNo);
	}
	
	public int deleteFile(String contentNo) throws Exception {
		int convertNo = Integer.parseInt(contentNo);
		return boardDAO.deleteFile(convertNo);
	}

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public BoardVO selectContent(BoardVO vo) throws Exception {
		BoardVO resultVO = boardDAO.selectContent(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	
	public List<BoardVO> selectBoardList(BoardVO vo) throws Exception {
		return boardDAO.selectBoardList(vo);
	}
	
	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectBoardListTotCnt(BoardVO searchVO) {
		return boardDAO.selectBoardListTotCnt(searchVO);
	}
	
	public BoardVO loginCheck(BoardVO vo) {
		return boardDAO.loginCheck(vo);
	}
	
	public int updateHit(int contentNo) throws Exception {
		return boardDAO.updateHit(contentNo);
	}
	
	public BoardVO getContent(BoardVO vo) {
		
		int prePage = boardDAO.prePage(vo);
		int nextPage = boardDAO.nextPage(vo);
		
		int contentNo = vo.getContentNo();
		BoardVO content = boardDAO.getContent(contentNo);
		
		content.setPrePage(prePage);
		content.setNextPage(nextPage);
		
		return content;
	}
	
	// 첨부파일 저장 logic
	public int fileSave(BoardVO vo, MultipartFile file) {
		// uuid와 currentTime을 이용하여 본 파일명을 대체하여 저장
		// 파일 저장 위치는 local로 지정
		String saveDir = "C:\\Users\\jespe\\Downloads\\boardfiles\\";
		String orgName = file.getOriginalFilename();
		String exName = orgName.substring(orgName.lastIndexOf("."));
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		String filePath = saveDir + saveName;
		long fileSize = file.getSize();
		
		// bVO라는 새로운 객체를 생성
		// vo로부터 content의 PK값이자 generateKey(오라클 selectKey)
		BoardVO bVO = new BoardVO();
		int boardNo = vo.getContentNo();
		bVO.setOrgName(orgName);
		bVO.setSaveName(saveName);
		bVO.setFilePath(filePath);
		bVO.setFileSize(fileSize);
		bVO.setContentNo(boardNo);
		
		// 파일 저장
		try {
			byte[] fileData = file.getBytes();
			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			bos.write(fileData);
			bos.close();
			
		}catch(IOException e){
			e.printStackTrace();
		}
		
		return boardDAO.fileInsert(bVO);
	}
	
	// 첨부파일 수정 logic (logic은 저장과 동일, 쿼리문만 update문)
	public int updateFile(BoardVO vo, MultipartFile file) {
		String saveDir = "C:\\Users\\jespe\\Downloads\\boardfiles\\";
		String orgName = file.getOriginalFilename();
		String exName = orgName.substring(orgName.lastIndexOf("."));
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		
		String filePath = saveDir + saveName;
		long fileSize = file.getSize();
		
		BoardVO bVO = new BoardVO();
		int filesNo = vo.getFilesNo();
		bVO.setOrgName(orgName);
		bVO.setSaveName(saveName);
		bVO.setFilePath(filePath);
		bVO.setFileSize(fileSize);
		bVO.setFilesNo(filesNo);
		
		try {
			byte[] fileData = file.getBytes();
			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			bos.write(fileData);
			bos.close();
			
		}catch(IOException e){
			e.printStackTrace();
		}
		
		return boardDAO.updateFile(bVO);
	}
	
	
	public int removeFile(BoardVO vo) {
		int filesNo = vo.getFilesNo();
		return boardDAO.removeFile(filesNo);
	}
	
	public List<BoardVO> getReplyList(String contentNo){
		int parseNo = Integer.parseInt(contentNo);
		return boardDAO.getReplyList(parseNo);
	}
	
	public int insertReply(BoardVO vo) {
		return boardDAO.insertReply(vo);
	}
	
	public int verifyUser(BoardVO vo) {
		return boardDAO.verifyUser(vo);
	}
	
	public int deleteReply(String replyNo) {
		int parseNo = Integer.parseInt(replyNo);
		return boardDAO.deleteReply(parseNo);
	}

}

package kr.or.ddit.attach.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.attach.model.AttachVo;

public interface IAttachService {
	/**
	 * Method : getAttachList
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return List<AttachVo>
	 * Method 설명 : 특정 게시글(공지사항 혹은 건의사항)의 전체 첨부파일 조회
	 */
	List<AttachVo> getAttachList(Map<String, String> map);
	
	/**
	 * Method : getAttach
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return AttachVo
	 * Method 설명 : 
	 */
	AttachVo getAttach(String attach_cd);
	
	/**
	 * Method : insertAttach
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 첨부파일 등록
	 */
	int insertAttach(AttachVo attachVo);
	
	/**
	 * Method : deleteAttach
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 첨부파일 삭제
	 */
	int deleteAttach(String attach_cd);
	
	/**
	 * Method : updateStatusY
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 삭제여부를 0(삭제)로 수정
	 */
	int updateStatusY(String attach_cd);
	
	/**
	 * Method : updateStatusN
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 삭제여부를 1(삭제아님)로 수정
	 */
	int updateStatusN(String attach_cd);
	
	/**
	 * Method : getAttachListY
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return List<AttachVo>
	 * Method 설명 : 특정 게시글(공지사항 혹은 건의사항)의 삭제여부가 0(삭제)인 첨부파일 조회
	 */
	List<AttachVo> getAttachListY(Map<String, String> map);
}

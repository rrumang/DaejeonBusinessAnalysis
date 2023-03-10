package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

public interface IMemberService {
	
	/**
	 * 
	* Method : insertMember
	* 작성자 : PC17
	* 변경이력 :
	* @param memverVo
	* @return
	* Method 설명 : 회원가입 용 메소드
	 */
	int insertMember(MemberVo memverVo);
	
	/**
	 * 
	* Method : getMember
	* 작성자 : PC17
	* 변경이력 :
	* @param member_id
	* @return
	* Method 설명  : 중복체크용
	 */
	int getMember(String member_id);
	
	/**
	 * 
	* Method : memberList
	* 작성자 : PC17
	* 변경이력 :
	* @return
	* Method 설명 : 모든멤버리스트 뽑아오기
	 */
	List<MemberVo> memberList();
	
	/**
	 * 
	* Method : memberFire
	* 작성자 : PC17
	* 변경이력 :
	* @param member_id
	* @return
	* Method 설명 : 회원탈퇴
	 */
	int memberFire(String member_id);
	
	/**
	 * 
	* Method : memberSearch
	* 작성자 : PC17
	* 변경이력 :
	* @param keyword
	* @return
	* Method 설명 :검색을통해 해당하는 회원정보 조회
	 */
	List<MemberVo> memberSearch(String keyword);
	
	// =====================================================================
	
	/**
	 * Method : normalLogin
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MemberVo
	 * Method 설명 : 회원아이디/카카오인증키/네이버인증키로 회원정보 조회
	 */
	MemberVo normalLogin(Map<String, String> map);
	
	/**
	 * Method : linkSocial
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 소셜계정연동
	 */
	int linkSocial(Map<String,String> map);
	
	/**
	 * Method : getFindingId
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MemberVo
	 * Method 설명 : 이메일과 전화번호가 일치하는 회원정보 조회
	 */
	MemberVo getFindingId(MemberVo memberVo);
	
	/**
	 * Method : getMemberInfo
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return MemberVo
	 * Method 설명 : 특정 회원 조회
	 */
	MemberVo getMemberInfo(String member_id);
	
	/**
	 * Method : modifyMember
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 회원정보 수정
	 */
	int modifyMember(MemberVo memberVo);
	
	/**
	 * Method : getInterestTob
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return TobVo
	 * Method 설명 : 회원의 관심업종 소, 중, 대분류코드 조회
	 */
	TobVo getInterestTob(String member_id);
	
	/**
	 * Method : getInterestRegion
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return RegionVo
	 * Method 설명 : 회원의 관심지역 동, 구코드 조회
	 */
	RegionVo getInterestRegion(String member_id);
	
	/**
	 * Method : withdrawMember
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return int
	 * Method 설명 : 회원 탈퇴 및 계정연동 해제
	 */
	int withdrawMember(String member_id);
	
	/**
	 * 
	* Method : getRegionName
	* 작성자 : 강민호
	* 변경이력 :
	* @param region_cd
	* @return
	* Method 설명 :
	 */
	String getRegionName(Long region_cd);

	
	/**
	 * 
	* Method : getTobName
	* 작성자 : 강민호
	* 변경이력 :
	* @param tob_cd
	* @return
	* Method 설명 : 업종코드로 일치하는 업종이름 가져오기
	 */
	String getTobName(String tob_cd);
	
	/**
	 * 
	* Method : memberPagingList
	* 작성자 : 강민호
	* 변경이력 :
	* @param pv
	* @return
	* Method 설명 :페이징처리된 멤버리스트 가져오기
	 */
	Map<String,Object> memberPagingList(PageVo pv);
	
	/**
	 * 
	* Method : searchTitle
	* 작성자 : 강민호
	* 변경이력 :
	* @param map
	* @return
	* Method 설명 : 키워드에 해당하는 페이징 리스트 가져오기
	 */
	Map<String, Object> searchTitle(Map<String,Object> map);
	

}

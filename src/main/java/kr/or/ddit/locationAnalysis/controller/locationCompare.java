package kr.or.ddit.locationAnalysis.controller;

import java.util.Comparator;

import kr.or.ddit.locationAnalysis.model.LocationaVo;

/**
 * 
* locationCompare.java
* 선택한 지역의 업종별 입지등급을 등급순으로 오름차순, 매출액으로 내림차순 정렬하는 클래스 
*
* @author 유민하
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 수정내용
* ------ ------------------------
* 유민하 최초 생성
*
* </pre>
 */
public class locationCompare implements Comparator<LocationaVo> {

	int ret = 0;
	
	/**
	 * 
	* Method : compare
	* 작성자 : 유민하
	* 변경이력 :
	* @param o1
	* @param o2
	* @return
	* Method 설명 : 선택한 지역의 업종별 입지등급을 등급순으로 오름차순, 매출액으로 내림차순 정렬하는 매서드 
	 */
	@Override
	public int compare(LocationaVo o1, LocationaVo o2) {
		if(o1.getGrade() > o2.getGrade()) {
			ret = 1;
		}
		if(o1.getGrade() == o2.getGrade()) {
			if(o1.getMaxx() > o2.getMaxx()) {
				ret = -1;
			}else if(o1.getMaxx() == o2.getMaxx()) {
				ret = 0;
			}else if(o1.getMaxx() < o2.getMaxx()) {
				ret = 1;
			}
		}
		if(o1.getGrade() < o2.getGrade()) {
			ret = -1;
		}
		return ret;
	}

}

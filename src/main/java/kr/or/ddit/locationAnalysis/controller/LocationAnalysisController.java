package kr.or.ddit.locationAnalysis.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.locationAnalysis.model.LocationAnalysisVo;
import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.locationAnalysis.service.ILocationAnalysisService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

/**
 * 
* LocationAnalysisController.java
* 입지분석 관련 클래스
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
@RequestMapping("/location")
@Controller
public class LocationAnalysisController {
	
	private static final Logger logger = LoggerFactory.getLogger(LocationAnalysisController.class);
	
	@Resource(name="locationAnalysisService")
	private ILocationAnalysisService locationAnalysisService;
	
	/**
	 * 
	* Method : showLocation
	* 작성자 : 유민하
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 입지분석을 위한 지역선택 화면 요청
	 */
	@RequestMapping(path = "/showLocation", method = RequestMethod.GET)
	public String showLocation(HttpSession session, Model model) {
		
		MemberVo memberVo = (MemberVo)session.getAttribute("MEMBER_INFO");

		if(memberVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		}

		List<RegionVo> rList = locationAnalysisService.getRegion();
		RegionVo rVo = new RegionVo();
		
		if(memberVo.getRegion_cd() != 0)
			rVo = locationAnalysisService.getInterestRegion(memberVo.getMember_id());
		
		model.addAttribute("regionList", rList); //지역목록
		model.addAttribute("interestRegion", rVo);// 관심지역 정보
		
		return "locationAnalysis/locationAnalysisAdd";
	}
	
	/**
	 * 
	* Method : inputlocationDong
	* 작성자 : 유민하
	* 변경이력 :
	* @param region_cd2
	* @param model
	* @return
	* Method 설명 : 선택한 구에 해당하는 동 목록을 출력
	 */
	@RequestMapping(path = "inputDong", method = RequestMethod.POST)
	@ResponseBody
	public List<RegionVo> inputlocationDong(int region_cd2, Model model){
		List<RegionVo> dongList = new ArrayList<RegionVo>();
		dongList = locationAnalysisService.getDong(region_cd2);
		
		model.addAttribute("data", dongList);
		
		return dongList;
	}
	
	/**
	 * 
	* Method : locationReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param dongcd
	* @param model
	* @return
	* Method 설명 : 입지분석 결과 출력
	 */
	@RequestMapping(path = "/locationReport", method = {RequestMethod.GET, RequestMethod.POST})
	public String locationReport(HttpSession session, long dongcd, Model model) {
		
		//세션에 담긴 회원정보 가져오기
		MemberVo memberVo = (MemberVo)session.getAttribute("MEMBER_INFO");
		String member_id = memberVo.getMember_id();
		
		//가져온 지역코드를 통해 해당 객체를 가져오기
		RegionVo regionVo = locationAnalysisService.getOneRegion(dongcd);
		
		//대전지역의 업종별 최고 매출액(기준데이터)
		List<LocationaVo> sList = locationAnalysisService.getStandard();
		
		//해당지역의 업종별 월매출액(대상데이터)
		List<LocationaVo> oList = locationAnalysisService.getObject(regionVo.getRegion_cd());
		
		//선택지역의 업종별 입지등급 구하기
		//최고매출액의 75%이상이면 1등급, 최고매출액의 60%이하면 3등급, 중간은 2등급
		for (int i = 0; i < sList.size(); i++) {
			for(LocationaVo oVo : oList) {
				if(oVo.getTob().equals(sList.get(i).getTob())) {
					if(oVo.getMaxx() >= sList.get(i).getMaxx()*0.75) {
						oVo.setGrade(1);
					}else if(oVo.getMaxx() <= sList.get(i).getMaxx()*0.6) {
						oVo.setGrade(3);
					}else {
						oVo.setGrade(2);
					}
				}
			}
		}
		
		int one   = 0;   // 1등급
		int two   = 0;   // 2등급
		int three = 0;   // 3등급
		
		//산술평균 구하기
		for (int i = 0; i < oList.size(); i++) {
			if(oList.get(i).getGrade() == 1) {
				one += oList.get(i).getGrade();
			}else if(oList.get(i).getGrade() == 2) {
				two += oList.get(i).getGrade();
			}else {
				three += oList.get(i).getGrade();
			}
		}
		
		//종합입지등급
		int grade = (int) Math.round((double)(one + two + three)/oList.size());
		
		//업종별 입지등급 구하기
		//업종코드에 해당하는 업종명을 세팅
		for (int i = 0; i < oList.size(); i++) {
			oList.get(i).setTob(locationAnalysisService.getTobName(oList.get(i).getTob()));
		}
		
		//등급순으로 오름차순, 매출액으로 내림차순 정렬 
		Collections.sort(oList, new locationCompare());
		
		//새보고서코드 가져오기
		String report_cd = locationAnalysisService.getReport_cd();
		
		//선택지역명 구하기
		long region_cd = regionVo.getRegion_cd();
		String region_csc = regionVo.getRegion_csc();
		
		String sigu = region_csc.substring(0, region_csc.indexOf("구")+1);
		StringBuffer sb = new StringBuffer(sigu);
		sb.append("").append(regionVo.getRegion_name());
		String addr = sb.toString();
		
		//잠재고객 분석하기
		//유동인구
		int movee = (int) (locationAnalysisService.getMove(regionVo.getRegion_cd()) / (double)5.5);
		//주거인구
		int live = locationAnalysisService.getLive(regionVo.getRegion_cd());
		//직장인구
		int jobb = locationAnalysisService.getJob(regionVo.getRegion_cd());
		
		String resultt = null;
		
		if(movee < live) {
			if(live < jobb) {
				resultt ="직장인구";
			}else {
				resultt ="주거인구";
			}
		}else {
			resultt = "유동인구";
		}
		
		//입지분석 보고서 저장
		ReportVo reportVo = new ReportVo(report_cd, member_id, region_cd);
		int interCnt1 = locationAnalysisService.insertReport(reportVo);
		
		//입지분석 저장
		LocationAnalysisVo locationAnalysisVo = new LocationAnalysisVo(report_cd, member_id, movee, live, jobb, resultt, grade, addr, region_cd, region_csc );
		int insertCnt2 = locationAnalysisService.insertLocationAnalysisVo(locationAnalysisVo);
		
		//선택지역 업종별 입지등급 저장
		for (int i = 0; i < oList.size(); i++) {
			oList.get(i).setReport_cd(report_cd);
			int insertCnt3 = locationAnalysisService.insertLocationaVo(oList.get(i));
		}
		
		model.addAttribute("move", movee);            //유동인구
		model.addAttribute("live", live);             //주거인구
		model.addAttribute("job", jobb);              //직장인구
		model.addAttribute("result", resultt);        //잠재고객
		model.addAttribute("grade", grade);           //종합입지등급
		model.addAttribute("resultList", oList);      //선택지역 업종별 등급
		model.addAttribute("selectAddr", addr);       //선택한 지역
		model.addAttribute("region_cd", region_cd);   //지역코드
		model.addAttribute("region_csc", region_csc); //주민센터주소
		model.addAttribute("report_cd", report_cd);   //보고서코드
		
		return "locationAnalysis/locationAnalysisReport";
	}
	
	/**
	 * 
	* Method : showLocationReport
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_cd
	* @param model
	* @return
	* Method 설명 : 분석보고서에서 보기를 클릭시 입지분석 화면 출력
	 */
	@RequestMapping(path = "/showLocationReport")
	public String showLocationReport(String report_cd, Model model) {
		
		//보고서코드로 해당지역의 업종별 입지등급 가져오기
		List<LocationaVo> oList = locationAnalysisService.getLocationa(report_cd);
		
		//등급순으로 오름차순, 매출액으로 내림차순 정렬 
		Collections.sort(oList, new locationCompare());
		
		//보고서코드로 해당지역의 입지분석 정보 가져오기
		LocationAnalysisVo la = locationAnalysisService.getLocationReport(report_cd);
		
		report_cd = report_cd.substring(6);
		logger.debug("▶report_cd:{}", report_cd);
		model.addAttribute("report_cd", report_cd);           //보고서코드
		model.addAttribute("move", la.getMovee());            //유동인구
		model.addAttribute("live", la.getLive());             //주거인구
		model.addAttribute("job", la.getJobb());              //직장인구
		model.addAttribute("result", la.getResultt());        //잠재고객
		model.addAttribute("grade", la.getGrade());           //종합입지등급
		model.addAttribute("resultList", oList);              //선택지역 업종별 등급
		model.addAttribute("selectAddr", la.getAddr());       //선택한 지역
		model.addAttribute("region_cd", la.getRegion_cd());   //지역코드
		model.addAttribute("region_csc", la.getRegion_csc()); //주민센터주소
		
		return "locationAnalysis/locationAnalysisReport";
	}
	
	/**
	 * 
	* Method : locationComparison
	* 작성자 : 유민하
	* 변경이력 :
	* @param report_cd1
	* @param report_cd2
	* @param model
	* @return
	* Method 설명 : 2개의 분석보고서를 선택시 비교분석 화면 출력
	 */
	@RequestMapping("/locationComparison")
	public String locationComparison(String report_cd1, String report_cd2, Model model) {
		
		//2개의 보고서코드를 받아 각각의 정보를 1과 2로 구분하여 담아준다
		List<LocationaVo> oList1 = locationAnalysisService.getLocationa(report_cd1);
		List<LocationaVo> oList2 = locationAnalysisService.getLocationa(report_cd2);
		
		Collections.sort(oList1, new locationCompare());
		Collections.sort(oList2, new locationCompare());
		
		LocationAnalysisVo la1 = locationAnalysisService.getLocationReport(report_cd1);
		LocationAnalysisVo la2 = locationAnalysisService.getLocationReport(report_cd2);
		
		model.addAttribute("move1", la1.getMovee());
		model.addAttribute("move2", la2.getMovee());
		
		model.addAttribute("live1", la1.getLive());
		model.addAttribute("live2", la2.getLive());
		
		model.addAttribute("job1", la1.getJobb());
		model.addAttribute("job2", la2.getJobb());
		
		model.addAttribute("result1", la1.getResultt());
		model.addAttribute("result2", la2.getResultt());
		
		model.addAttribute("grade1", la1.getGrade());
		model.addAttribute("grade2", la2.getGrade());
		
		model.addAttribute("selectAddr1", la1.getAddr());
		model.addAttribute("selectAddr2", la2.getAddr());
		
		model.addAttribute("region_cd1", la1.getRegion_cd());
		model.addAttribute("region_cd2", la2.getRegion_cd());
		
		model.addAttribute("region_csc1", la1.getRegion_csc());
		model.addAttribute("region_csc2", la2.getRegion_csc());
		
		model.addAttribute("resultList1", oList1);
		model.addAttribute("resultList2", oList2);
		
		return "locationAnalysis/comparisonAnalysis";
	}
	
	/**
	 * 
	* Method : excelDown
	* 작성자 : 유민하
	* 변경이력 :
	* @param request
	* @param report_cd
	* @param response
	* @param model
	* @throws ParsePropertyException
	* @throws InvalidFormatException
	* @throws IOException
	* Method 설명 : 해당하는 보고서를 엑셀로 다운로드 하는 메소드
	 */
	@RequestMapping("/excel")
	public void excelDown(HttpServletRequest request, String report_cd, HttpServletResponse response, Model model) throws ParsePropertyException, InvalidFormatException, IOException {
		
		//보고서코드로 해당지역의 업종별 입지등급 가져오기
		List<LocationaVo> oList = locationAnalysisService.getLocationa("report"+report_cd);
		
		//등급순으로 오름차순, 매출액으로 내림차순 정렬 
		Collections.sort(oList, new locationCompare());
		
		//보고서코드로 해당지역의 입지분석 정보 가져오기
		LocationAnalysisVo la = locationAnalysisService.getLocationReport("report"+report_cd);

		//맵에 가져온 정보를 넣어준다
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("resultList", oList);        //업종별 입지등급
		beans.put("selectAddr", la.getAddr()); //선택한 지역
		beans.put("move", la.getMovee());      //유동인구
		beans.put("live", la.getLive());       //주거인구
		beans.put("job", la.getJobb());        //직장인구
		beans.put("grade", la.getGrade());     //종합입지등급
		
		//엑셀 다운로드 메소드가 담겨 있는 객체
		MakeExcel me = new MakeExcel();
		
		//인자로 request, response, Map Collection 객체, 다운시 파일명, 견본파일을 받음
		me.download(request, response, beans, me.get_Filename("locationAnalysis"), "locationAnalysis.xlsx");
	}
}

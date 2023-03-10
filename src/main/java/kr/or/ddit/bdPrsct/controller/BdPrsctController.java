package kr.or.ddit.bdPrsct.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.bdAnalysis.service.IBdAnalysisService;
import kr.or.ddit.bdPrsct.model.BusinessmanVo;
import kr.or.ddit.bdPrsct.model.LeaseVo;
import kr.or.ddit.bdPrsct.model.PrintVo;
import kr.or.ddit.bdPrsct.model.SalesPresentVo;
import kr.or.ddit.bdPrsct.model.StoreCntVo;
import kr.or.ddit.bdPrsct.model.UtilizeVo;
import kr.or.ddit.bdPrsct.service.IBdPrsctService;
import kr.or.ddit.data.model.LatLngVo;
import kr.or.ddit.data.model.StoreVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.net.aso.e;

@RequestMapping("/bdPrsct")
@Controller
public class BdPrsctController {
	
	private static final Logger logger = LoggerFactory.getLogger(BdPrsctController.class);
	
	@Resource(name = "bdPrsctService")
	private IBdPrsctService bdPrsctService;

	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	/**
	* Method : showBusinessPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 업소현황 화면요청
	*/
	@RequestMapping(path = "/businessPrsct", method = RequestMethod.GET)
	public String showBusinessPrsct(Model model) {
		
		List<RegionVo> guList = bdPrsctService.getGuList();
		List<TobVo> tobClList = bdPrsctService.getTobCl1List();
		
		model.addAttribute("guList", guList);
		model.addAttribute("tobClList", tobClList);
		
		return "bdPrsct/businessPrsct";
	}
	
	/**
	* Method : getTobCl2
	* 작성자 : 박영춘
	* 변경이력 :
	* @param tob_cd
	* @param model
	* @return
	* Method 설명 : 선택한 대분류에 해당하는 중분류 목록을 출력
	*/
	@RequestMapping(path = "/getTobCl2", method = RequestMethod.POST)
	@ResponseBody
	public List<TobVo> getTobCl2(String tob_cd, Model model) {
		
		List<TobVo> tobCl2List = new ArrayList<TobVo>();
		tobCl2List = bdPrsctService.getTobCl2List(tob_cd);
		
		return tobCl2List;
	}
	
	/**
	* Method : getBusinessPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 시 전체, 구, 동단위 반기별 업소수
	*/
	@RequestMapping(path = "/getBPrsct", method = RequestMethod.POST)
	@ResponseBody
	public List<PrintVo> getBusinessPrsct(Model model, String tob_cd, int gu) {
		List<PrintVo> bpList = bdPrsctService.getBusinessPrsct(tob_cd, gu);
		model.addAttribute("bpList", bpList);
		return bpList;
	}
	
	/**
	* Method : showSalesPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 매출현황 화면요청
	*/
	@RequestMapping(path = "/salesPrsct", method = RequestMethod.GET)
	public String showSalesPrsct(Model model) {
		
		List<RegionVo> guList = bdPrsctService.getGuList();
		List<TobVo> tobClList = bdPrsctService.getTobCl1List();
		
		model.addAttribute("guList", guList);
		model.addAttribute("tobClList", tobClList);
		
		return "bdPrsct/salesPrsct";
	}
	
	/**
	* Method : getSalesPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 반기별 매출액, 건단가
	*/
	@RequestMapping(path = "/getSPrsct", method = RequestMethod.POST)
	@ResponseBody
	public List<SalesPresentVo> getSalesPrsct(Model model, String tob_cd, int gu){
		List<SalesPresentVo> spList = bdPrsctService.getSalesPrsct(tob_cd, gu);
		model.addAttribute("spList", spList);
		return spList;
	}
	
	/**
	* Method : showLeasePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 임대시세현황 출력
	*/
	@RequestMapping(path = "/leasePrsct", method = RequestMethod.GET)
	public String showLeasePrsct(Model model) {
		List<LeaseVo> leaseList = bdPrsctService.getLeasePrsct();
		model.addAttribute("leaseList", leaseList);
		return "bdPrsct/leasePrsct";
	}
	
	/**
	* Method : showFcPrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 창폐업률현황 출력
	*/
	@RequestMapping(path = "/fcPrsct", method = RequestMethod.GET)
	public String showFcPrsct(Model model) {
		List<BusinessmanVo> fcList = bdPrsctService.getFcPrsct();
		model.addAttribute("fcList", fcList);
		return "bdPrsct/fcPrsct";
	}
	
	/**
	* Method : showUtilizePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 활용현황 화면요청
	*/
	@RequestMapping(path = "/utilizePrsct", method = RequestMethod.GET)
	public String showUtilizePrsct(Model model) {
		
		List<RegionVo> guList = bdPrsctService.getGuList();
		List<TobVo> tobClList = bdPrsctService.getTobCl1List();
		
		model.addAttribute("guList", guList);
		model.addAttribute("tobClList", tobClList);
		
		return "bdPrsct/utilizePrsct";
	}
	
	/**
	* Method : getUtilizePrsct
	* 작성자 : 박영춘
	* 변경이력 :
	* @param model
	* @param tob_cd
	* @param gu
	* @return
	* Method 설명 : 선택한 업종의 구단위 분석횟수
	*/
	@RequestMapping(path = "/getUtilizePrsct", method = RequestMethod.POST)
	@ResponseBody
	public List<UtilizeVo> getUtilizePrsct(Model model, String tob_cd, int gu) {
		List<UtilizeVo> upList = bdPrsctService.getUtilizePrsct(tob_cd, gu);
		model.addAttribute("upList", upList);
		return upList;
	}
	
	
	
	
	/**
	* Method : showBdInvestigate
	* 작성자 : 김환석
	* 변경이력 : 
	* @return
	* Method 설명 : 상권조사 페이지 요청
	*/
	@RequestMapping(path = "/bdInvestigate", method = RequestMethod.GET)
	public String showBdInvestigate(Model model) {
		
		// 시군구 리스트 가져오기
		List<RegionVo> guList = bdAnalysisService.getGuList();
		model.addAttribute("guList", guList);
		
		return "bdPrsct/bdInvestigation";
	}
	
	
	/**
	* Method : guListLookUp
	* 작성자 : 김환석
	* 변경이력 :
	* @return
	* Method 설명 : 상권분석 정보 입력페이지에서 대전시의 동 리스트를 조회하기 위한 jsonView
	*/
	@RequestMapping(path = "/dongListLookUp", method = RequestMethod.GET)
	public String guListLookUp(Model model, int region_cd2) {
		List<RegionVo> dongList = bdAnalysisService.getDongList(region_cd2);
		model.addAttribute("dongList", dongList);
		
		return "jsonView";
	}
	
	
	/**
	* Method : getStoreList
	* 작성자 : hs
	* 변경이력 :
	* @param model
	* @param data
	* @return
	* Method 설명 : 상권조사 페이지에서 카카오 지도의 영역 좌표 배열을 받아와
	* 해당 좌표 영역안에 존재하는 상가 리스트를 조회하는 ajax요청 
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(path = "/getStoreList", method = RequestMethod.POST)
	@ResponseBody
	public List<StoreVo> getStoreList(Model model,
									@RequestBody String points) {
		// 상권조사 페이지에서 넘어온 다각형 영역의 좌표값 배열
		List<Map<String, Object>>resultMap = new ArrayList<Map<String,Object>>();
		resultMap = JSONArray.fromObject(points);
		
		// DB에 인자로 넘길 좌표값들의 List
		List<LatLngVo> pointList = new ArrayList<LatLngVo>();
		
		for(Map<String, Object> map : resultMap) {
			logger.debug("@@@@@ map.get('x') : {}", map.get("x"));	// 경도
			logger.debug("@@@@@ map.get('y') : {}", map.get("y"));	// 위도
			// 좌표 값을 받을 vo 객체
			LatLngVo point = new LatLngVo();
			point.setLng((double)map.get("x"));	// 경도 값 셋팅
			point.setLat((double)map.get("y"));	// 위도 값 셋팅ㅊ
			pointList.add(point);	// 셋팅된 좌표객체를 리스트에 추가
		}
		
		// parameter인자로 넘길 map객체 이곳에 위 좌표값 리스트를 담아 넘겨준다
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("pointList", pointList);
		// 위 다각형 영역 안에 존재하는 상가 리스트를 조회
//		model.addAttribute("storeList",bdPrsctService.getStoreList(param));
		
		List<StoreVo> storeList = bdPrsctService.getStoreList(param);
		return storeList;
	}
	

	
	/**
	* Method : getStoreList_circle
	* 작성자 : hs
	* 변경이력 :
	* @param model
	* @param datas
	* @return
	* Method 설명 : 상권조사 페이지에서 카카오 지도의 원형 영역 좌표 점 3개를 받아와
	* 해당 좌표 영역안에 존재하는 상가 리스트를 조회하는 ajax요청 
	*/
	@RequestMapping(path = "/getStoreList_Circle", method= RequestMethod.POST)
	@ResponseBody
	public List<StoreVo> getStoreList_circle(Model model,
				@RequestBody Map<String, Object> datas) {
		JSONObject center = JSONObject.fromObject(datas.get("center"));
		JSONObject sPoint = JSONObject.fromObject(datas.get("sPoint"));
		JSONObject ePoint = JSONObject.fromObject(datas.get("ePoint"));
		
		logger.debug("@@@@@ datas : {}", center);
		logger.debug("@@@@@ center.x : {}", center.getDouble("x"));
		logger.debug("@@@@@ center.y : {}", center.getDouble("y"));
		logger.debug("@@@@@ datas : {}", sPoint);
		logger.debug("@@@@@ datas : {}", ePoint);
		LatLngVo centerVo = new LatLngVo(center.getDouble("x"), center.getDouble("y"));
		LatLngVo spVo = new LatLngVo(sPoint.getDouble("x"), sPoint.getDouble("y"));
		LatLngVo epVo = new LatLngVo(ePoint.getDouble("x"), ePoint.getDouble("y"));
		
//		centerVo.setLng(centerVo.getLng() + (centerVo.getLng() - epVo.getLng()));
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("center", centerVo);
		params.put("ePoint", epVo);
		params.put("sPoint", spVo);
		
//		model.addAttribute("storeList", bdPrsctService.getStoreList_Circle(params));
		List<StoreVo> storeList = bdPrsctService.getStoreList_Circle(params);
		
		return storeList;
 	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(path = "/getStoreCnt_Polygon", method= RequestMethod.POST)
	@ResponseBody
	public List<StoreCntVo> getStoreCnt_Polygon(Model model, 
											@RequestBody String data){
		// 상권조사 페이지에서 넘어온 다각형 영역의 좌표값 배열
		List<Map<String, Object>>resultMap = new ArrayList<Map<String,Object>>();
		resultMap = JSONArray.fromObject(data);
		logger.debug("@@@@@@ resultMap : {}", resultMap);
		// DB에 인자로 넘길 좌표값들의 List
		List<LatLngVo> pointList = new ArrayList<LatLngVo>();
		
		for(Map<String, Object> map : resultMap) {
			logger.debug("@@@@@ map.get('x') : {}",(double) map.get("x"));	// 경도
			logger.debug("@@@@@ map.get('y') : {}", (double) map.get("y"));	// 위도
			// 좌표 값을 받을 vo 객체
			LatLngVo point = new LatLngVo();
			point.setLng((double)map.get("x"));	// 경도 값 셋팅
			point.setLat((double)map.get("y"));	// 위도 값 셋팅ㅊ
			pointList.add(point);	// 셋팅된 좌표객체를 리스트에 추가
		}
		
		// parameter인자로 넘길 map객체 이곳에 위 좌표값 리스트를 담아 넘겨준다
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("pointList", pointList);
		logger.debug("@@@@@@pointList: {}", pointList);
		
		List<StoreCntVo> storeCntList = bdPrsctService.getStoreCnt_Polygon(param);
		
		return storeCntList;
	}
	
	
	@RequestMapping(path = "/getStoreCnt_Circle", method= RequestMethod.POST)
	@ResponseBody
	public List<StoreCntVo> getStoreCnt_Circle(Model model,
						@RequestBody Map<String, Object> datas){
		JSONObject center = JSONObject.fromObject(datas.get("center"));
		JSONObject sPoint = JSONObject.fromObject(datas.get("sPoint"));
		JSONObject ePoint = JSONObject.fromObject(datas.get("ePoint"));
		
		logger.debug("@@@@@ datas : {}", center);
		logger.debug("@@@@@ center.x : {}", center.getDouble("x"));
		logger.debug("@@@@@ center.y : {}", center.getDouble("y"));
		logger.debug("@@@@@ datas : {}", sPoint);
		logger.debug("@@@@@ datas : {}", ePoint);
		LatLngVo centerVo = new LatLngVo(center.getDouble("x"), center.getDouble("y"));
		LatLngVo spVo = new LatLngVo(sPoint.getDouble("x"), sPoint.getDouble("y"));
		LatLngVo epVo = new LatLngVo(ePoint.getDouble("x"), ePoint.getDouble("y"));
		
//		centerVo.setLng(centerVo.getLng() + (centerVo.getLng() - epVo.getLng()));
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("center", centerVo);
		params.put("ePoint", epVo);
		params.put("sPoint", spVo);
		
		List<StoreCntVo> storeCntList = bdPrsctService.getStoreCnt_Circle(params);
		
		return storeCntList;
	}
	
}

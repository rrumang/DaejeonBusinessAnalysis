package kr.or.ddit.main.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.bdAnalysis.model.EvaluationVo;
import kr.or.ddit.bdAnalysis.service.IBdAnalysisService;
import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.faq.service.IFaqService;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.freeBoard.service.IFreeBoardService;
import kr.or.ddit.locationAnalysis.controller.locationCompare;
import kr.or.ddit.locationAnalysis.model.LocationAnalysisVo;
import kr.or.ddit.locationAnalysis.model.LocationaVo;
import kr.or.ddit.locationAnalysis.service.ILocationAnalysisService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.report.model.ReportVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.suggestion.model.SuggestionVo;
import kr.or.ddit.suggestion.service.ISuggestionService;
import kr.or.ddit.tobRecom.service.ITobRecomService;


@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Resource(name="freeBoardService")
	private IFreeBoardService fBoardService;
	
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@Resource(name = "tobRecomService")
	private ITobRecomService tobRecomService;
	
	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	@Resource(name="locationAnalysisService")
	private ILocationAnalysisService locationAnalysisService;
	
	@Resource(name="noticeService")
	private INoticeService noticeService;
	
	@Resource(name="faqService")
	private IFaqService faqService;
	
	@Resource(name="suggestionService")
	private ISuggestionService suggestionService;
	
	
	@RequestMapping("/main")
	public String main(Model model, HttpSession session) {
		// ???????????? ????????????
		if(session.getAttribute("MESSAGE") != null) {
			model.addAttribute("MESSAGE", session.getAttribute("MESSAGE"));
			session.removeAttribute("MESSAGE");
		}
		
		// ?????????????????? ??? ?????????????????? ???????????? ????????????
		if(session.getAttribute("WELCOM") != null) {
			model.addAttribute("WELCOM", session.getAttribute("WELCOM"));
			session.removeAttribute("WELCOM");
		}
		
		// ?????????????????? ??? ??????????????? ?????? ???????????? ????????? --> ???????????? ???????????? ??????
		if(session.getAttribute("KAKAO") != null || session.getAttribute("NAVER") != null) {
			session.removeAttribute("KAKAO");
			session.removeAttribute("NAVER");
		}
		
		
		List<RegionVo> rList = new ArrayList<RegionVo>();
		RegionVo rVo = new RegionVo();
		rList = tobRecomService.getRegion();
		MemberVo memberVo = new MemberVo();
		
		
		if (memberVo.getRegion_cd() != 0)
			rVo = tobRecomService.getInterestRegion(memberVo.getMember_id());

		model.addAttribute("regionList", rList);
		model.addAttribute("interestRegion", rVo);
		
		List<FreeBoardVo> fBoardList = new ArrayList<FreeBoardVo>(); 
		fBoardList = fBoardService.getMainFreeboard();
		
		logger.debug("fBoardList : {}",fBoardList);
		model.addAttribute("fBoardList",fBoardList);
		
		// ???????????? ????????? 5???
		List<NoticeVo> noticeList = noticeService.getNoticeMain();
		model.addAttribute("noticeList", noticeList);
		
		//FAQ ????????? 5???
		List<FaqVo> faqList = faqService.getFaqMain();
		model.addAttribute("faqList", faqList);
		
		//???????????? 5???
		List<SuggestionVo> suggestionList = suggestionService.getMainSuggestionList();
		model.addAttribute("suggestionList", suggestionList);
		
		
		return "tiles.main";
	}
	
	@RequestMapping(path="/simple_analysis",method=RequestMethod.POST)
	public String simple_analysis(Model model, long dong) {
		logger.debug("dong : {}",dong);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		
		resultMap = bdAnalysisService.getEvaluationInfo(dong);
		resultMap.get("evalInfo");
		
		logger.debug("@resultMap12 : {}",resultMap);
		// ??????????????? ????????????????????? ?????? ???????????? ?????? ??????????????? ???????????? ??????
		resultMap.get("evalRateOfChange");
		EvaluationVo ev = (EvaluationVo) resultMap.get("evalInfo");
		
		logger.debug("@@@@@@evalInfo : {}",ev.getEvaluation_sales_growth());
		float growth = ev.getEvaluation_sales_growth()+ev.getEvaluation_important();
		logger.debug("growth : {}",growth);//?????????
		float stability = ev.getEvaluation_variability()+ev.getEvaluation_closure();
		logger.debug("stability : {}",stability);//?????????
		//?????????
		float purchasePower = ev.getEvaluation_sales_scale()+ev.getEvaluation_consumptionlevel()+ev.getEvaluation_payment();
		logger.debug("purchasePower : {}",purchasePower);//?????????
		
		//?????????
		float visitPower = ev.getEvaluation_lp()+ev.getEvaluation_pp()+ev.getEvaluation_wp();
		logger.debug("visitPower : {}",visitPower);//?????????
		//??????
		float evaluation = growth +stability +purchasePower +visitPower;
		logger.debug("evaluation : {}",evaluation);
		
		model.addAttribute("growth",growth);
		model.addAttribute("stability",stability);
		model.addAttribute("purchasePower",purchasePower);
		model.addAttribute("visitPower",visitPower);
		model.addAttribute("evaluation",evaluation);
		
		return "jsonView";
	}
	
	@RequestMapping(path="/logOut")
	public String logOut(Model model,HttpSession session,HttpServletResponse response) {
		
		List<FreeBoardVo> fBoardList = new ArrayList<FreeBoardVo>(); 
		fBoardList = fBoardService.getMainFreeboard();
		logger.debug("fBoardList : {}",fBoardList);
		model.addAttribute("fBoardList",fBoardList);
		
		session.invalidate();
		
		return "redirect:/main";
	}
}

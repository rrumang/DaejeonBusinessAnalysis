package kr.or.ddit.faq.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.faq.service.IFaqService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;

/**
 * 
* FaqController.java
* FAQ게시판 관련 클래스
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
@RequestMapping("/faq")
@Controller
public class FaqController {
	private static final Logger logger = LoggerFactory.getLogger(FaqController.class);
	
	@Resource(name="faqService")
	private IFaqService faqService;
	
	/**
	 * 
	* Method : faqPagingList
	* 작성자 : 유민하
	* 변경이력 :
	* @param pageVo
	* @param model
	* @return
	* Method 설명 : faq게시판 페이징 처리 된 목록 조회
	 */
	@RequestMapping("/faqList")
	public String faqPagingList(HttpSession session, PageVo pageVo, Model model, String query) {
		
		int grade = 0;
		
		//비회원일 경우 임시로 등급을 2로 지정
		MemberVo memberVo = (MemberVo)session.getAttribute("MEMBER_INFO");
		if(memberVo == null) {
			grade = 2;
		}else{
			grade = memberVo.getMember_grade();
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 검색 키워드가 없는 경우
		if(query == null) {
			resultMap = faqService.faqPagingList(pageVo);
		
		} else { // 검색 키워드가 있는 경우
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("faq_title", query);
			map.put("page", pageVo.getPage());
			map.put("pageSize", pageVo.getPageSize());
			
			resultMap = faqService.searchTitle(map);
			model.addAttribute("query", query);
		}

		//페이징 처리된 FAQ게시판 목록 가져오기
		List<FaqVo> faqList = (List<FaqVo>) resultMap.get("faqList");
		int paginationSize = (Integer)resultMap.get("paginationSize");
		
		model.addAttribute("grade", grade);
		model.addAttribute("faqList", faqList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);

		return "faq/faqList";
	}
	
	/**
	 * 
	* Method : faqAdd
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : faq게시판 게시글 등록화면 요청
	 */
	@RequestMapping(path="/faqAdd", method= RequestMethod.GET)
	public String faqAdd() {
		return "faq/faqAdd";
	}
	
	/**
	 * 
	* Method : faqAdd
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @param result
	* @return
	* Method 설명 : faq게시판 게시글 등록
	 */
	@RequestMapping(path="/faqAdd", method = RequestMethod.POST)
	public String faqAdd(FaqVo faqVo, BindingResult result ) {
		logger.debug("***faq : {}", faqVo);
		String faq_cd = faqService.getFaq_cd();
		faqVo.setFaq_cd(faq_cd);
		
		int insertCnt = faqService.insertFaq(faqVo);
		return "redirect:/faq/faqList";
	}
	
	/**
	 * 
	* Method : faqModify
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @param model
	* @return
	* Method 설명 : faq게시판 게시글 수정화면 요청
	 */
	@RequestMapping(path="/faqModify")
	public String faqModify(String faq_cd, Model model) {
		model.addAttribute("faqVo", faqService.getFaq(faq_cd));
		return "faq/faqList";
	}
	
	/**
	 * 
	* Method : faqModify
	* 작성자 : 유민하
	* 변경이력 :
	* @param faqVo
	* @param result
	* @return
	* Method 설명 : faq게시판 게시글 수정
	 */
	@RequestMapping(path="/faqModify", method = RequestMethod.POST)
	public String faqModify(FaqVo faqVo, BindingResult result) {
		int updateCnt = faqService.updateFaq(faqVo);
		return "redirect:/faq/faqList";
	}
	
	/**
	 * 
	* Method : faqDelete
	* 작성자 : 유민하
	* 변경이력 :
	* @param faq_cd
	* @return
	* Method 설명 : faq게시판 게시글 삭제
	 */
	@RequestMapping(path="/faqDelete", method = RequestMethod.POST)
	public String faqDelete(String faq_cd) {
		int deleteCnt = faqService.deleteFaq(faq_cd);
		return "redirect:/faq/faqList";
	}
	
}

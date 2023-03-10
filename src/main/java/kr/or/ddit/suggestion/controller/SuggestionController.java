package kr.or.ddit.suggestion.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.attach.model.AttachVo;
import kr.or.ddit.attach.service.IAttachService;
import kr.or.ddit.freeBoard.model.CommentVo;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.suggestion.model.SuggestionVo;
import kr.or.ddit.suggestion.service.ISuggestionService;

@Controller
public class SuggestionController {
	
	@Resource(name="suggestionService")
	private ISuggestionService suggestionService;
	
	@Resource(name="attachService")
	private IAttachService attachService;
	
	private static final Logger logger = LoggerFactory.getLogger(SuggestionController.class);
	
	/**
	 * 
	* Method : suggestionList
	* 작성자 : 강민호
	* 변경이력 :
	* @return
	* Method 설명 : 전체 건의사항 리스트 불러오기
	 */
	@RequestMapping("/suggestion")
	public String suggestionList(Model model,HttpSession session,String keyword,PageVo pageVo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		session.setAttribute("sg_parent1", null);
		
		if(keyword == null) {
			resultMap = suggestionService.getAllSuggestion(pageVo);
			
		}else {
			Map<String, Object>map = new HashMap<String, Object>();
			map.put("keyword", keyword);
			map.put("page", pageVo.getPage());
			map.put("pageSize", pageVo.getPageSize());
			
			resultMap = suggestionService.getKeywordSuggestion(map);
			model.addAttribute("keyword",keyword);
		}
		List<SuggestionVo> suggestionList = (List<SuggestionVo>) resultMap.get("suggestionList");
		int paginationSize = (int) resultMap.get("paginationSize");
		
		model.addAttribute("suList",suggestionList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);
		
		return "tiles.suList";
	}
	
	@RequestMapping(path="/parentVo",method=RequestMethod.POST)
	public String suggestion(Model model, String real_cd) {
		
		
		
		//클릭한 글의 부모글(코드)을 가져오자 
		SuggestionVo sv=suggestionService.getSuggestion(real_cd);
		String parent =  sv.getSuggestion_cd2();
		//부모글 코드로 부모글의 작성자를 찾자
		SuggestionVo sv2=suggestionService.getSuggestion(parent);
		String parent2 = sv2.getMember_id();
		
		model.addAttribute("parent",parent2);
		
		
		
		
		return "jsonView";
	}
	
	@RequestMapping("/suggestionAdd")
	public String suggestionAdd(Model model, HttpSession session, String sg_parent1) {
		
		if(sg_parent1!=null) {
			SuggestionVo sv = suggestionService.getSuggestion(sg_parent1);
			session.setAttribute("sg_parent1", sv);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		if(memberVo== null) {
			session.setAttribute("MESSAGE", "로그인 후 사용가능합니다.");
			return "redirect:/login";
		} 
		
		return "tiles.suggestionAdd";
	}
	
	@RequestMapping(path="/suggestionModify", method=RequestMethod.POST)
	public String su_modify(Model model, HttpSession session,String suggestion_cd2, String[] oldAttach, 
			HttpServletRequest request,String su_title2,String su_content2,int su_secret_yn2) {
		
		if(session.getAttribute("MEMBER_INFO") == null) {
			return "redirect:/suggestion";
		}
		
		SuggestionVo sv = new SuggestionVo(suggestion_cd2, su_title2, su_content2, su_secret_yn2);
		int cnt =suggestionService.getSuggestionUpdate(sv);
		
		//노티스
		if(cnt > 0) {
			logger.debug("----------------------글 수정 성공했니?-------------------");
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "suggestion_cd");
			map.put("data", suggestion_cd2);
			
			List<AttachVo> attachList = attachService.getAttachList(map);
			
			// 첨부파일 리스트가 null이 아닐 때 비교
			if(attachList != null) {
				for(AttachVo attachVo : attachList) {
					// 첨부파일 삭제여부를 0(삭제)로 수정
					attachService.updateStatusY(attachVo.getAttach_cd());
				}
				
				// 글 수정 후 기존 첨부파일이 있다면 해당 첨부파일은 다시 삭제여부를 1(삭제아님)로 수정
				if(oldAttach!= null) {
					for(String attach_cd : oldAttach) {
						if(attach_cd != null) {
							logger.debug("▶ attach_cd : {}", attach_cd);
							attachService.updateStatusN(attach_cd);
						}
					}
				}
				
				// 해당 게시글의 삭제여부가 0(삭제)인 리스트 가져오기
				List<AttachVo> attachListY = attachService.getAttachListY(map);
				
				if(attachListY != null) {
					for(AttachVo attachVo : attachListY) {
						// db에서 삭제
						int cnt2 = attachService.deleteAttach(attachVo.getAttach_cd());
						
						if(cnt2 > 0) {
							// disk에서 삭제
							File file = new File(attachVo.getAttach_path());
							
							if(file.exists()) {
								file.delete();
							}
						}
					}
				}
			}
			
			// 새롭게 추가된 첨부파일 추가
			request.setAttribute("suggestion_cd", suggestion_cd2);
			//model.addAttribute("suggestion_cd2",suggestion_cd2)
			return "forward:/attach/upload";
		}
		
		
		return "tiles.suggestion_detail";
	}
	
	
	
	
	/**
	 * 
	* Method : suggestionAdd
	* 작성자 : 강민호
	* 변경이력 :
	* @param model
	* @param session
	* @param fv
	* @return
	* Method 설명 : 건의게시판 게시물 생성
	 */
	@RequestMapping(path="/insertSuggestion",method=RequestMethod.POST)
	public String suggestionAdd(Model model,HttpSession session,SuggestionVo sv,HttpServletRequest request) {
		Date date = new Date(); 
		String fb_cd = "";
		
		int result = 0;
		MemberVo mv = (MemberVo) session.getAttribute("MEMBER_INFO");
		 if(session.getAttribute("sg_parent1")!=null) {
			 SuggestionVo sv4 = (SuggestionVo) session.getAttribute("sg_parent1");
			 String sg_parent_cd = sv4.getSuggestion_cd();
			 SuggestionVo sv3 = new SuggestionVo(fb_cd, mv.getMember_id(), fb_cd, sg_parent_cd, sv.getSg_title(), sv.getSg_content(), date, sv.getSg_secret_yn(), 1);
			 result = suggestionService.insertReply(sv3);
		 }else{
			 SuggestionVo sv2 = new SuggestionVo(fb_cd, mv.getMember_id(), fb_cd, null, sv.getSg_title(), sv.getSg_content(), date, sv.getSg_secret_yn(), 1);
			 result = suggestionService.insertSuggesion(sv2);
		 }

		 if(result > 0) {
			 String str = suggestionService.getLastSg().getSuggestion_cd();
			 request.setAttribute("suggestion_cd", str);
			 return "forward:/attach/upload";
		 }
		 
		 session.setAttribute("sg_parent1", null);
		 return "redirect:/suggestion";
	}
	
	@RequestMapping(path="/suBoard_Detail")
	public String suggestion_detail(Model model,HttpSession session,String suggestion_cd) {
		
		session.setAttribute("suggestion_cd", suggestion_cd);
		SuggestionVo sv2 = suggestionService.getSuggestion(suggestion_cd);
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		String session_id = memberVo.getMember_id();
		session.setAttribute("session_id", session_id);
		
		
		int reply_status = suggestionService.getReply(suggestion_cd);
		logger.debug("reply_status : {}",reply_status);
		model.addAttribute("reply_status",reply_status);
		
		if(memberVo == null) {
			String member_id = "";
			model.addAttribute("suggestionVo",sv2);
			model.addAttribute("memberId",member_id);
		}else {
			String member_id = memberVo.getMember_id();
			int member_grade = memberVo.getMember_grade();
			
			model.addAttribute("suggestionVo",sv2);
			model.addAttribute("memberId",member_id);
			model.addAttribute("grade",member_grade);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("column", "suggestion_cd");
		map.put("data", suggestion_cd);
		
		List<AttachVo> attachList = attachService.getAttachList(map);
		if(attachList != null) {
			model.addAttribute("attachList", attachList);
		}
		
		return "tiles.suggestion_detail";
	}
	
	@RequestMapping(path="/SuggestionSearch",method=RequestMethod.POST)
	public String freeSearch(Model model, HttpSession session,String keyword) {
		
		List<SuggestionVo> boardList = new ArrayList<SuggestionVo>(); 
		
		
				
		boardList = suggestionService.getSearchSuggestionBoard(keyword);
		logger.debug("keyword :{}",keyword);
		logger.debug("boardList :{}",boardList);
		
		model.addAttribute("suList",boardList);
		
		return "tiles.suList";
	}
	
	@RequestMapping("/SuggestionDlete")
	public String freeDelete(Model model, HttpSession session, FreeBoardVo fv,String suggestion_cd1) {
		//String freeBoard_cd = fv.getFreeboard_cd();
		
		suggestionService.getSuggestionDelete(suggestion_cd1);
		
		return "redirect:/suggestion";
		
	}

}

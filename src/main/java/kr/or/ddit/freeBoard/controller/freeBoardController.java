package kr.or.ddit.freeBoard.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.freeBoard.model.CommentVo;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.freeBoard.service.IFreeBoardService;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;

@Controller
public class freeBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(freeBoardController.class);
	
	@Resource(name="freeBoardService")
	private IFreeBoardService fBoardService;
	
	
	/**
	 * 
	* Method : freeList
	* 작성자 : 강민호
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 자유게시판 리스트
	 */
	@RequestMapping("/freeBoard")
	public String freeList(Model model, HttpSession session,String keyword,PageVo pageVo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(keyword == null) { //검색어가 없는 경우ㅠ
			resultMap = fBoardService.getAllFreeboard(pageVo);
		} else {
			Map<String , Object> map = new HashMap<String, Object>();
			map.put("keyword", keyword);
			map.put("page", pageVo.getPage());
			map.put("pageSize", pageVo.getPageSize());
			
			resultMap =  fBoardService.searchTitle(map);
			model.addAttribute("keyword",keyword);
			
		}
		
		List<FreeBoardVo> fBoardList = (List<FreeBoardVo>) resultMap.get("freeboardList"); 
		int paginationSize = (int)resultMap.get("paginationSize");
		
		model.addAttribute("fBoardList",fBoardList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);
		
		return "tiles.f_bList";
	}
	
	
	/**
	 * 
	 * Method : freeList
	 * 작성자 : 강민호
	 * 변경이력 :
	 * @param model
	 * @return
	 * Method 설명 : 자유게시판 리스트에서 게시글을 클릭할 때
	 */
	@RequestMapping(path="/freeBoard_Detail")
	public String fb_Detail(Model model, HttpSession session,FreeBoardVo fv,String freeboard_cd) {
		
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		session.setAttribute("freeboard_cd", freeboard_cd);
		FreeBoardVo fv1 =  fBoardService.getFreeBoard(freeboard_cd);
		int status = fv1.getFb_yn();
		
		if(status == 0) {
			return "redirect:/freeBoard";
		}
		
		
		if(memberVo == null) {
			
			FreeBoardVo fv2 = fBoardService.getFreeBoard(freeboard_cd);
			List<CommentVo> comList = fBoardService.getComList(freeboard_cd);
			
			String member_id = "";
			model.addAttribute("freeBoardVo1",fv2);
			model.addAttribute("memberId",member_id);
			model.addAttribute("comList",comList);
			
		}else {
		
			logger.debug("freeboard_cd : {}",freeboard_cd);
			FreeBoardVo fv2 = fBoardService.getFreeBoard(freeboard_cd);
			List<CommentVo> comList = fBoardService.getComList(freeboard_cd);
			logger.debug("comList : {}",comList);
			logger.debug("fv2 : {}",fv2);
			
			MemberVo mv = (MemberVo) session.getAttribute("MEMBER_INFO");
			
			String memberId = mv.getMember_id();
			int member_grade = mv.getMember_grade();
			
			model.addAttribute("comList",comList);
			model.addAttribute("freeBoardVo1",fv2);
			model.addAttribute("memberId",memberId);
			model.addAttribute("grade",member_grade);
		}
		
		return "tiles.f_bDetail";
	}
	
	/**
	 * 
	* Method : freeAdd
	* 작성자 : 강민호
	* 변경이력 :
	* @param model
	* @param session
	* @return
	* Method 설명 : 게시물 생성페이지 이동
	 */
	@RequestMapping("/freeBoardAdd")
	public String freeAdd(Model model,HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		if(memberVo == null) {
			session.setAttribute("MESSAGE", "로그인이 필요한 기능입니다.");
			return "redirect:/login";
		} 
		
		return "tiles.f_bAdd";
	}
	
	/**
	 * 
	* Method : freeAdd
	* 작성자 : 강민호
	* 변경이력 :
	* @param model
	* @param session
	* @param fv
	* @return
	* Method 설명 : 자유게시판 게시물 생성
	 */
	@RequestMapping(path="/insertfreeboard",method=RequestMethod.POST)
	public String freeAdd(Model model,HttpSession session,FreeBoardVo fv) {
		
		Date date = new Date(); 
		String fb_cd = "";
		MemberVo mv = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		if(fv.getFb_title() == null) {
			session.setAttribute("MESSAGE", "제목을 입력하세요.");
			return "redirect:/freeBoardAdd";
		}else if(fv.getFb_content() == null) {
			session.setAttribute("MESSAGE", "내용을 입력하세요.");
			return "redirect:/freeBoardAdd";
		}
		
		FreeBoardVo fv2 = new FreeBoardVo(fb_cd, mv.getMember_id(), fv.getFb_title(), fv.getFb_content(), date, 1);
		
		
		logger.debug("session.getId() : {}",mv.getMember_id());
		logger.debug("fv.getFb_title() : {}",fv.getFb_title());
		logger.debug("fv.getFb_content() : {}",fv.getFb_content());
		fBoardService.insertF_board(fv2);
		
		return "redirect:/freeBoard";
	}
	
	/**
	 * 
	 * Method : freeAdd
	 * 작성자 : 강민호
	 * 변경이력 :
	 * @param model
	 * @param session
	 * @param fv
	 * @return
	 * Method 설명 : 자유게시판 게시물 등록
	 */
	@RequestMapping("/freeboardDetail")
	public String freeDetail(Model model,HttpSession session,FreeBoardVo fv) {
		
		Date date = new Date(); 
		String fb_cd = "";
		MemberVo mv = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		if(fv.getFb_title() == null) {
			session.setAttribute("MESSAGE", "제목을 입력하세요.");
			return "redirect:/freeBoardAdd";
		}else if(fv.getFb_content() == null) {
			session.setAttribute("MESSAGE", "내용을 입력하세요.");
			return "redirect:/freeBoardAdd";
		}
		
		FreeBoardVo fv2 = new FreeBoardVo(fb_cd, mv.getMember_id(), fv.getFb_title(), fv.getFb_content(), date, 1);
		
		
		logger.debug("session.getId() : {}",mv.getMember_id());
		logger.debug("fv.getFb_title() : {}",fv.getFb_title());
		logger.debug("fv.getFb_content() : {}",fv.getFb_content());
		fBoardService.insertF_board(fv2);
		
		return "tiles.f_bDetail";
	}
	
	@RequestMapping("/Freedelete")
	public String freeDelete(Model model, HttpSession session, FreeBoardVo fv,String freeboard_cd1) {
		String freeBoard_cd = fv.getFreeboard_cd();
		logger.debug("freeBoard_cd : {}",freeboard_cd1);
		
		fBoardService.getFreedelete(freeboard_cd1);
		
		return "redirect:/freeBoard";
		
	}
	@RequestMapping(path="/FreeSearch",method=RequestMethod.POST)
	public String freeSearch(Model model, HttpSession session,String keyword) {
		
		List<FreeBoardVo> boardList = new ArrayList<FreeBoardVo>();  
				
		boardList = fBoardService.getSearchFreeBoard(keyword);
		logger.debug("keyword :{}",keyword);
		logger.debug("boardList :{}",boardList);
		
		model.addAttribute("fBoardList",boardList);
		
		return "tiles.f_bList";
	}
	
	@RequestMapping("/FreeModify")
	public String freeModify(Model model, HttpSession session, FreeBoardVo fv,String fb_content2,String fb_title2,String freeboard_cd2) {
		String freeboard_cd = freeboard_cd2;
		String fb_title=fb_title2;
		String fb_content=fb_content2;
		
		logger.debug("freeboard_cd2 : {}",freeboard_cd2);
		logger.debug("fb_title2 : {}",fb_title2);
		logger.debug("fb_content2 : {}",fb_content2);
		
		FreeBoardVo fv2=new FreeBoardVo(freeboard_cd, fb_title, fb_content);
		
		fBoardService.getFreeUpdate(fv2);
		
		model.addAttribute("freeboard_cd",session.getAttribute("freeboard_cd"));
		
		model.addAttribute("freeBoardVo1",fv2);
		
		
		return "redirect:/freeBoard_Detail";
	}
	
	@RequestMapping(path="/Comment",method=RequestMethod.POST)
	public String comment(Model model,HttpSession session,String fb_comment) {
		
		String freeboard_cd = (String)session.getAttribute("freeboard_cd");
		MemberVo mv  = (MemberVo) session.getAttribute("MEMBER_INFO");
		String member_id = mv.getMember_id();
		String seq = "";
		Date date = new Date();
		List<CommentVo> comList = fBoardService.getComList(freeboard_cd);
		String memberId = mv.getMember_id();
		model.addAttribute("memberId",memberId);
		
		logger.debug("freeboard_cd:{}",freeboard_cd);
		
		CommentVo cv  = new CommentVo(seq, freeboard_cd, member_id, fb_comment, date, 1);
		FreeBoardVo fv2 = fBoardService.getFreeBoard(freeboard_cd);
		String cd =cv.getCm_content();
		fBoardService.getInsertCommnet(cv);
		model.addAttribute("cv",cv);
		model.addAttribute("comList",comList);
		model.addAttribute("freeBoardVo1",fv2);
			
		return "redirect:/Comment";
		
	}
	
	@RequestMapping("/Comment")
	public String comment(Model model,HttpSession session,String fb_comment, String faq_title) {
		
		logger.debug("faq_title :{}",faq_title);
		
		// VO에 넣을재료들
		String freeboard_cd = (String) session.getAttribute("freeboard_cd");
		MemberVo mv  = (MemberVo) session.getAttribute("MEMBER_INFO");
		String member_id = mv.getMember_id();
		String seq = "";
		Date date = new Date();
		
		List<CommentVo> comList = fBoardService.getComList(freeboard_cd);
		String memberId = mv.getMember_id();
		model.addAttribute("memberId",memberId);
		//
		
		
		logger.debug("freeboard_cd:{}",freeboard_cd);
		//모아놓은재료  VO에 넣기
		CommentVo cv  = new CommentVo(seq, freeboard_cd, member_id, fb_comment, date, 1);
		//
		
		FreeBoardVo fv2 = fBoardService.getFreeBoard(freeboard_cd);
		String cd =cv.getCm_content();
		// 재료들 댓글테이블에 넣기
//		fBoardService.getInsertCommnet(cv);
		model.addAttribute("comList",comList);
		model.addAttribute("freeBoardVo1",fv2);
		
		
		return "tiles.f_bDetail";
		
	}
	
	@RequestMapping("/delete")
	public String deleteComment(Model model,HttpSession session, String comment_cd1) {
		String freeboard_cd = (String) session.getAttribute("freeboard_cd");
		MemberVo mv  = (MemberVo) session.getAttribute("MEMBER_INFO");
		String memberId = mv.getMember_id();
		
		logger.debug("comment_cd1:{}",comment_cd1);
		fBoardService.getDeleteComment(comment_cd1);
		
		List<CommentVo> comList = fBoardService.getComList(freeboard_cd);
		FreeBoardVo fv2 = fBoardService.getFreeBoard(freeboard_cd);
		
		model.addAttribute("comList",comList);
		model.addAttribute("freeBoardVo1",fv2);
		model.addAttribute("memberId",memberId);
		
		return "tiles.f_bDetail";
	}
	
	
	
}

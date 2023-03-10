package kr.or.ddit.notice.controller;

import java.io.File;
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
import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.paging.model.PageVo;

@RequestMapping("/notice")
@Controller
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Resource(name="noticeService")
	private INoticeService service;
	
	@Resource(name="attachService")
	private IAttachService attachService;
	
	/**
	 * Method : noticeList
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시판 리스트 화면 요청 (검색 포함)
	 */
	@RequestMapping(path="/noticeList", method = RequestMethod.GET)
	public String noticeList(Model model, PageVo pageVo, String query, HttpSession session) {
		if(session.getAttribute("MESSAGE") != null) {
			model.addAttribute("MESSAGE", session.getAttribute("MESSAGE"));
			session.removeAttribute("MESSAGE");
		};
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 검색 키워드가 없는 경우
		if(query == null) {
			resultMap = service.getAllNotice(pageVo);
			
		} else { // 검색 키워드가 있는 경우
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("notice_title", query);
			map.put("page", pageVo.getPage());
			map.put("pageSize", pageVo.getPageSize());
			
			resultMap = service.searchTitle(map);
			model.addAttribute("query", query);
		}
		
		List<NoticeVo> noticeList = (List<NoticeVo>) resultMap.get("noticeList");
		int paginationSize = (int) resultMap.get("paginationSize");
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("paginationSize", paginationSize);
		model.addAttribute("pageVo", pageVo);
		
		return "notice/noticeList";
	}
	
	/**
	 * Method : noticeDetail
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 상세보기화면 요청
	 */
	@RequestMapping(path = "/noticeDetail", method = RequestMethod.GET)
	public String noticeDetail(Model model, String notice_cd, HttpSession session) {
		NoticeVo noticeVo = service.getNotice(notice_cd);
		
		if(noticeVo == null || noticeVo.getNotice_yn() == 0) {
			session.setAttribute("MESSAGE", "존재하지 않는 게시글입니다.");
			return "redirect:/notice/noticeList";
		}
		
		// message가 있으면 (첨부파일이 존재하지 않습니다 - 라는 메세지)
		if(session.getAttribute("MESSAGE") != null) {
			model.addAttribute("MESSAGE", session.getAttribute("MESSAGE"));
			session.removeAttribute("MESSAGE");
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("column", "notice_cd");
		map.put("data", notice_cd);
		
		List<AttachVo> attachList = attachService.getAttachList(map);
		if(attachList != null) {
			model.addAttribute("attachList", attachList);
		}
		
		model.addAttribute("noticeVo", noticeVo);
		return "notice/noticeDetail";
	}
	
	/**
	 * Method : noticeAdd
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 등록화면 요청
	 */
	@RequestMapping(path = "/noticeAdd", method = RequestMethod.GET)
	public String noticeAddView() {
		return "notice/noticeAdd";
	}
	
	/**
	 * Method : noticeAdd
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 등록 처리
	 */
	@RequestMapping(path = "/noticeAdd", method = RequestMethod.POST)
	public String noticeAdd(NoticeVo noticeVo, HttpServletRequest request) {
		String notice_cd = service.insertNotice(noticeVo);
		
		if(notice_cd != null) {
			request.setAttribute("notice_cd", notice_cd);
			return "forward:/attach/upload";
		}
		
		return "redirect:/notice/noticeAdd";
	}
	
	/**
	 * Method : noticeDelete
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 삭제 처리
	 */
	@RequestMapping(path = "/noticeDelete", method = RequestMethod.GET)
	public String noticeDelete(String notice_cd) {
		int cnt = service.updateStatus(notice_cd);
		
		// 공지사항 게시글 삭제(삭제여부 0으로 수정) 성공 시
		if(cnt > 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "notice_cd");
			map.put("data", notice_cd);
			
			List<AttachVo> attachList = attachService.getAttachList(map);
			
			// 첨부파일 리스트가 null이 아니면
			if(attachList != null) {
				for(AttachVo attachVo : attachList) {
					// db에서 삭제
					int cnt2 = attachService.deleteAttach(attachVo.getAttach_cd());
					
					if(cnt2 > 0) {
						File file = new File(attachVo.getAttach_path());
						
						// disk에서 삭제
						if(file.exists()) {
							file.delete();
						}
					}
				}
			}
		}
		
		return "redirect:/notice/noticeList";
	}
	
	/**
	 * Method : noticeModifyView
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 수정화면 요청
	 */
	@RequestMapping(path = "/noticeModify", method = RequestMethod.GET)
	public String noticeModifyView(String notice_cd, Model model) {
		NoticeVo noticeVo = service.getNotice(notice_cd);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("column", "notice_cd");
		map.put("data", notice_cd);
		
		List<AttachVo> attachList = attachService.getAttachList(map);
		if(attachList != null) {
			model.addAttribute("attachList", attachList);
		}
		
		model.addAttribute("noticeVo", noticeVo);
		return "notice/noticeModify";
	}
	
	/**
	 * Method : notiecModify
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 공지사항 게시글 수정 처리
	 */
	@RequestMapping(path = "/noticeModify", method = RequestMethod.POST)
	public String notiecModify(NoticeVo noticeVo, String[] oldAttach, HttpServletRequest request) {
		String notice_cd = noticeVo.getNotice_cd();
		
		int cnt = service.updateNotice(noticeVo);
				
		if(cnt > 0) {
			// 기존에 db에 저장되어있던 해당 게시글의 첨부파일 리스트 가져오기
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "notice_cd");
			map.put("data", notice_cd);
			
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
			request.setAttribute("notice_cd", notice_cd);
			return "forward:/attach/upload";
		}
		
		return "redirect:/notice/noticeDetail?notice_cd=" + notice_cd;
	}
}

package kr.or.ddit.attach.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.attach.model.AttachVo;
import kr.or.ddit.attach.service.IAttachService;
import kr.or.ddit.util.PartUtil;

@RequestMapping("/attach")
@Controller
public class AttachController {

	@Resource(name = "attachService")
	private IAttachService service;
	
	/**
	 * Method : fileUpload
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 첨부파일 정보 db에 저장 및 disk 저장
	 */
	@RequestMapping(path="/upload", method = RequestMethod.POST)
	public String fileUpload(HttpServletRequest request , MultipartHttpServletRequest mhRequest) {
		String notice_cd = null;
		String suggestion_cd = null;
		
		if(request.getAttribute("notice_cd") != null) {
			notice_cd = (String) request.getAttribute("notice_cd");
		}
		
		if(request.getAttribute("suggestion_cd") != null) {
			suggestion_cd = (String) request.getAttribute("suggestion_cd");
		}
		
		List<MultipartFile> file = mhRequest.getFiles("file");
		
		int cnt = 0;
		int count = 0;
		for(MultipartFile f : file) {
			if(f.getSize() > 0) {
				count++;
				
				String attach_name = f.getOriginalFilename();
				String ext = PartUtil.getExt(attach_name);
				
				String uploadPath = PartUtil.getUploadPath();
				String attach_path = uploadPath + File.separator + UUID.randomUUID().toString() + ext;
				
				File uploadFile = new File(attach_path);
				
				try {
					f.transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				cnt += service.insertAttach(new AttachVo(notice_cd, suggestion_cd, attach_name, attach_path));
			}
		}
		
		// 추가해야하는 파일 수와 insert한 수가 같으면
		if(cnt == count) {
			if(notice_cd != null) {
				return "redirect:/notice/noticeDetail?notice_cd=" + notice_cd;
			}
			
			if(suggestion_cd != null) {
				return "redirect:/suBoard_Detail?suggestion_cd=" + suggestion_cd;
			}
		} else {
			if(notice_cd != null) {
				return "redirect:/notice/noticeAdd";
			}
			
			if(suggestion_cd != null) {
				if(request.getSession().getAttribute("sg_parent1")!=null) {
					String sg_parent1 = (String) request.getSession().getAttribute("sg_parent1");
				
					return "redirect:/suggestionAdd?sg_parent1="+sg_parent1;
				}
			}
		}
		
		return "redirect:/main";
	}
	
	/**
	 * Method : fileDownload
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 첨부파일 다운로드 처리
	 */
	@RequestMapping("/download")
	public String fileDownload(String attach_cd, Model model, HttpSession session) {
		AttachVo attachVo = service.getAttach(attach_cd);
		
		// 첨부파일이 disk에 존재하는 지 확인
		File file = new File(attachVo.getAttach_path());
		
		// 파일이 존재하지 않으면
		if(!file.exists()) {
			// 공지사항 게시글에 있는 첨부파일일 때
			if(attachVo.getNotice_cd() != null) {
				session.setAttribute("MESSAGE", "파일이 존재하지 않아 다운로드가 불가능합니다.");
				return "redirect:/notice/noticeDetail?notice_cd=" + attachVo.getNotice_cd();
			// 건의사항 게시글에 있는 첨부파일일 때
			} else if(attachVo.getSuggestion_cd() != null) {
				session.setAttribute("MESSAGE", "파일이 존재하지 않아 다운로드가 불가능합니다.");
				return "redirect:/suBoard_Detail?suggestion_cd=" + attachVo.getSuggestion_cd();
			}
		}
		
		model.addAttribute("attachVo", attachVo);
		return "fileDownloadView";
	}
}

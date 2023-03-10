package kr.or.ddit.login.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.encrypt.kisa.sha256.KISA_SHA256;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;

/**
 * LoginController.java
 * 로그인 화면 요청, 처리 등을 하는 클래스
 * 
 * @author CHOEUNJU
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 * 수정자 수정내용
 * ------ ------------------------
 * CHOEUNJU 최초 생성
 *
 * </pre>
 */
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name="memberService")
	private IMemberService service;
	
	/**
	 * Method : loginView
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 로그인 화면 요청
	 */
	@RequestMapping(path="/login", method = RequestMethod.GET)
	public String loginView(HttpSession session, Model model) {
		if(session.getAttribute("MEMBER_INFO") == null) {
			String message = (String) session.getAttribute("MESSAGE");
			session.removeAttribute("MESSAGE");
			
			model.addAttribute("MESSAGE", message);
			return "login/login";
		} else {
			String message = "이미 로그인되어있습니다.";
			session.setAttribute("MESSAGE", message);
			
			return "redirect:/main";
		}
	}
	
	/**
	 * Method : normalLogin
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 일반 로그인 처리 요청
	 */
	@RequestMapping(path="/normalLogin", method = RequestMethod.POST)
	public String normalLogin(MemberVo memVo, Model model, HttpSession session) {
		logger.debug("▶ memVo : {}", memVo);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("column", "member_id");
		map.put("data", memVo.getMember_id());
		
		MemberVo memberVo = service.normalLogin(map);
		String password = KISA_SHA256.encrypt(memVo.getMember_password());
		logger.debug("▶ password : {}", password);
		String msg = "";
		
		if(memberVo != null && memberVo.getMember_password().equals(password) && memberVo.getMember_grade() != 3) {
			// session에 카카오/네이버 인증키가 있는 경우 (소셜로그인 최초 요청)
			String kakao = "";
			String naver = "";
			
			// 카카오 인증키가 있으면 해당 회원의 카카오 인증키 추가
			if(session.getAttribute("KAKAO") != null) {
				logger.debug("▶ 카카오인증");
				
				kakao = (String) session.getAttribute("KAKAO");
	
				Map<String, String> kakaoMap = new HashMap<String, String>();
				kakaoMap.put("column", "MEMBER_KAKAO_KEY");
				kakaoMap.put("data", kakao);
				kakaoMap.put("member_id", memberVo.getMember_id());
				
				int cnt = service.linkSocial(kakaoMap);
				
				if(cnt > 0) {
					memberVo.setMember_kakao_key(kakao);
				}
				
				session.removeAttribute("KAKAO");
				session.setAttribute("MEMBER_INFO", memberVo);
				return "redirect:/main";
			// 네이버 인증키가 있으면 해당 회원의 네이버 인증키 추가
			} else if(session.getAttribute("NAVER") != null) {
				logger.debug("▶ 네이버인증");
				
				naver = (String) session.getAttribute("NAVER");
				
				Map<String, String> naverMap = new HashMap<String, String>();
				naverMap.put("column", "member_naver_key");
				naverMap.put("data", naver);
				naverMap.put("member_id", memberVo.getMember_id());
				
				int cnt = service.linkSocial(naverMap);
				
				if(cnt > 0) {
					memberVo.setMember_naver_key(naver);
				}
				
				session.removeAttribute("NAVER");
				session.setAttribute("MEMBER_INFO", memberVo);
				return "redirect:/main";
			
			// 임시비밀번호와 동일하면 비밀번호변경화면으로 이동
			} else if(session.getAttribute("TEMPORARY") != null) {
				String temporary = (String) session.getAttribute("TEMPORARY");
				if(memVo.getMember_password().equals(temporary)) {
					session.setAttribute("MEMBER_INFO", memberVo);
					return "redirect:/modifyPw";
				} else {
					session.setAttribute("MEMBER_INFO", memberVo);
					return "redirect:/main";
				}
			// 일반 로그인
			} else {
				session.setAttribute("MEMBER_INFO", memberVo);
				return "redirect:/main";
			}
			
		} else if(memberVo == null) {
			msg = "아이디가 일치하는 회원이 존재하지 않습니다.";
		} else if(!memberVo.getMember_password().equals(password)){
			msg = "아이디 또는 비밀번호가 일치하지 않습니다";
		} else if(memberVo.getMember_grade() == 3) {
			msg = "탈퇴한 회원입니다.";
		}
		model.addAttribute("MESSAGE", msg);
		return "login/login";
	}
	
	/**
	 * Method : findId
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 아이디 찾기 결과를 반환하는 메서드
	 */
	@RequestMapping(path="/findId", method=RequestMethod.POST)
	public String findId(Model model, MemberVo memVo) {
		MemberVo memberVo = service.getFindingId(memVo);
		model.addAttribute("memberVo", memberVo);
		
		return "jsonView";
	}
	
	/**
	 * Method : findPw
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 비밀번호 찾기 결과를 반환하는 메서드
	 */
	@RequestMapping(path="/findPw", method = RequestMethod.POST)
	public String findPw(Model model, MemberVo memVo) {
		MemberVo memberVo = service.getFindingId(memVo);
		
		// 이메일과 휴대전화번호가 일치하는 회원이 존재하면
		if(memberVo != null) {
			// 메일 전송메서드로 위임
			return "forward:/sendMail?member_id=" + memberVo.getMember_id();
		}
		
		model.addAttribute("result", "none");
		
		return "jsonView";
	}
	
	/**
	 * Method : sendMail
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 임시비밀번호를 메일로 전송하고 회원의 비밀번호를 암호화한 임시비밀번호로 수정
	 */
	@RequestMapping(path="/sendMail", method=RequestMethod.POST)
	public String sendMail(MemberVo memberVo, Model model, HttpSession session) {
		logger.debug("▶ memberVo : {}", memberVo);
		
		// 임시비밀번호 생성
		String temporaryPw = UUID.randomUUID().toString().substring(0, 8);
		
		String result = "";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 받는 사람 이메일 주소
			messageHelper.setTo(memberVo.getMember_email());
		
			// 메일 제목
			messageHelper.setSubject("[POJO-대전광역시 상권분석] 임시비밀번호가 발급되었습니다.");
			
			// 메일 본문
			messageHelper.setText("임시비밀번호는 [" + temporaryPw + "] 입니다. 해당 비밀번호로 로그인하여 주시기 바랍니다.");
			
			// 보내는 사람
			messageHelper.setFrom("201901_pojo@naver.com");
			
			// 메일 전송
			mailSender.send(message);
			
			// 세션에 임시비밀번호 담기
			session.setAttribute("TEMPORARY", temporaryPw);
			
			// 임시비밀번호 암호화
			String encryptPw = KISA_SHA256.encrypt(temporaryPw);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "member_password");
			map.put("data", encryptPw);
			map.put("member_id", memberVo.getMember_id());
			
			// 임시비밀번호로 비밀번호 변경
			int cnt = service.linkSocial(map);
			
			if(cnt > 0) {
				result = "success";
			}
		} catch (MessagingException e) {
			e.printStackTrace();
			result = "error";
		}
		
		model.addAttribute("result", result);
		
		return "jsonView";
	}
	
	/**
	 * Method : socialLoginView
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 카카오/네이버 로그인 시도 시 발급받은 인증키를 세션에 저장하고
	 * 				 인증키가 일치하는 회원이 있는 경우 메인으로,
	 * 				 일치하는 회원이 없는 경우 일반로그인 화면으로 이동
	 */
	@RequestMapping(path = "/social", method = RequestMethod.POST)
	public String socialLoginView(MemberVo memVo, HttpSession session) {
		
		logger.debug("▶ memberVo : {}", memVo);
		
		if(memVo.getMember_kakao_key() != null && memVo.getMember_kakao_key().length() != 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "member_kakao_key");
			map.put("data", memVo.getMember_kakao_key());
			
			MemberVo memberVo = service.normalLogin(map);
			
			// 카카오인증키가 일치하는 회원이 존재하는 경우
			// --> 메인으로 이동
			if(memberVo != null) {
				session.setAttribute("MEMBER_INFO", memberVo);
				return "redirect:/main";
			}
			
			session.setAttribute("KAKAO", memVo.getMember_kakao_key());
		
		} else if(memVo.getMember_naver_key() != null && memVo.getMember_naver_key().length() != 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "member_naver_key");
			map.put("data", memVo.getMember_naver_key());
			
			MemberVo memberVo = service.normalLogin(map);
			
			// 네이버인증키가 일치하는 회원이 존재하는 경우
			// --> 메인으로 이동
			if(memberVo != null) {
				session.setAttribute("MEMBER_INFO", memberVo);
				return "redirect:/main";
			} 
			
			session.setAttribute("NAVER", memVo.getMember_naver_key());
		}
		
		return "login/login";
	}
	
	/**
	 * Method : naverCallback
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 네이버 로그인 콜백 페이지 호출
	 */
	@RequestMapping(path="/naverCallback", method = RequestMethod.GET)
	public String naverCallback() {
		return "login/naverCallback";
	}
	
	/**
	 * Method : modifyPw
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 임시비밀번호로 로그인 시 비밀번호변경 화면으로 이동
	 */
	@RequestMapping(path="/modifyPw", method = RequestMethod.GET)
	public String modifyPwView() {
		return "tiles.modifyPw";
	}
	
	/**
	 * Method : modifyPw
	 * 작성자 : CHOEUNJU
	 * 변경이력 :
	 * @return String
	 * Method 설명 : 비밀번호 변경 처리 후 메인화면으로 이동
	 */
	@RequestMapping(path="/modifyPw", method = RequestMethod.POST)
	public String modifyPw(String member_password, HttpSession session, Model model) {
		if(session.getAttribute("MEMBER_INFO") == null) {
			String message = (String) session.getAttribute("MESSAGE");
			session.removeAttribute("MESSAGE");
			
			model.addAttribute("MESSAGE", message);
			return "login/login";
		} else {
			MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
			
			String encryptPw = KISA_SHA256.encrypt(member_password);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("column", "member_password");
			map.put("data", encryptPw);
			map.put("member_id", memberVo.getMember_id());
			
			int cnt = service.linkSocial(map);
			
			if(cnt > 0) {
				memberVo.setMember_password(encryptPw);
				session.setAttribute("MEMBER_INFO", memberVo);
			}
			
			session.removeAttribute("TEMPORARY");
			
			return "redirect:/main";
		}
	}
}

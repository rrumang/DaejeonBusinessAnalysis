package kr.or.ddit.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.bdAnalysis.service.IBdAnalysisService;
import kr.or.ddit.encrypt.kisa.sha256.KISA_SHA256;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;
import kr.or.ddit.tobRecom.service.ITobRecomService;

@Controller
public class MemberController {
	
	@Resource(name="memberService")
	private IMemberService memberService;
	
	@Resource(name = "tobRecomService")
	private ITobRecomService tobRecomService;
	
	@Resource(name = "bdAnalysisService")
	private IBdAnalysisService bdAnalysisService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping(path="/register",method = RequestMethod.POST)
	
	public String insertMember(Model model,MemberVo memberVo,String member_email,String emailAddress,String backNumber, String middleNumber,String frontNumber,String year,String month, String day,HttpSession session,HttpServletResponse response,String bot,String dong) throws ParseException {
		if(dong.equals("all")) {
			dong  = null;
		}
		if(bot.equals("all")) {
			bot = null;
		}
		
		//???????????? ??????
		String memberId = memberVo.getMember_id();
		String memberName = memberVo.getMember_name();
		String memberPassword = memberVo.getMember_password();
		String memberEmail = member_email+emailAddress;
		String memberTel = frontNumber+"-"+middleNumber+"-"+backNumber;
		String birth = year+"-"+month+"-"+day;
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date = dt.parse(birth); 
		int member_grade = 2;
		int member_gender =  memberVo.getMember_gender();
		String viewName = "";
//		long real_dong=0L;
//		if(dong!=null) {
//			real_dong = Long.parseLong(dong);// ????????????????????? ????????????
//		}
		
		List<RegionVo> dongList = new ArrayList<RegionVo>();

		model.addAttribute("data", dongList);
		
		// userVo.setPass(KISA_SHA256.encrypt(userVo.getPass()));
		//????????????
		
		//????????? ????????????
		
		
			MemberVo memberVo2 = new MemberVo(memberId, memberPassword, memberName, memberEmail, memberTel, member_gender, date, member_grade);
			memberVo2.setTob_cd(bot);
			if(dong!=null) {
				memberVo2.setRegion_cd(Long.parseLong(dong));// ????????????????????? ????????????
			}
			memberVo2.setMember_password(KISA_SHA256.encrypt(memberPassword));
			
			logger.debug("memberVo2 : {}", memberVo2);
			
			memberService.insertMember(memberVo2);
			
			//-------------------------------------------------------------------------
			// ?????????, ????????? ?????? ????????? ?????? ??? ??????????????? ???????????? ??????
			// ???????????? ??? ?????? ???????????? ????????????
			
			// session??? ?????????/????????? ???????????? ?????? ?????? (??????????????? ?????? ??????)
			String kakao = "";
			String naver = "";
			
			// ????????? ???????????? ????????? ?????? ????????? ????????? ????????? ??????
			if(session.getAttribute("KAKAO") != null) {
				logger.debug("??? ???????????????");
				
				kakao = (String) session.getAttribute("KAKAO");
	
				Map<String, String> kakaoMap = new HashMap<String, String>();
				kakaoMap.put("column", "MEMBER_KAKAO_KEY");
				kakaoMap.put("data", kakao);
				kakaoMap.put("member_id", memberVo2.getMember_id());
				
				int cnt = memberService.linkSocial(kakaoMap);
				
				if(cnt > 0) {
					memberVo2.setMember_kakao_key(kakao);
				}
				
				session.removeAttribute("KAKAO");
				session.setAttribute("WELCOM", "???????????? ??? KAKAO ?????? ????????? ?????????????????????. ???????????? KAKAO ???????????? ???????????? ??????????????? ??? ????????????.");

			// ????????? ???????????? ????????? ?????? ????????? ????????? ????????? ??????
			} else if(session.getAttribute("NAVER") != null) {
				logger.debug("??? ???????????????");
				
				naver = (String) session.getAttribute("NAVER");
				
				Map<String, String> naverMap = new HashMap<String, String>();
				naverMap.put("column", "member_naver_key");
				naverMap.put("data", naver);
				naverMap.put("member_id", memberVo2.getMember_id());
				
				int cnt = memberService.linkSocial(naverMap);
				
				if(cnt > 0) {
					memberVo2.setMember_naver_key(naver);
				}
				
				session.removeAttribute("NAVER");
				session.setAttribute("WELCOM", "???????????? ??? NAVER ?????? ????????? ?????????????????????. ???????????? NAVER ???????????? ???????????? ??????????????? ??? ????????????.");
				
			}
			//-------------------------------------------------------------------------
			
			session.setAttribute("MEMBER_INFO", memberVo2);
			logger.debug("???????????? ??????");
			
			viewName = "redirect:/main";
		
		//???????????? 
		return viewName;
		
	}
	
	@RequestMapping(path="/duplication",method=RequestMethod.POST)
	public String idDuplication(String member_id,Model model) {
		
		int result = memberService.getMember(member_id);
		
		model.addAttribute("result",result);
		
		logger.debug("result : {}",result);
		
		return "jsonView";
	}
	
	//===========================================
	
		@RequestMapping("/promise")
		public String promise(Model model,HttpSession session) {
			return "member/promise";
		}
	
		@RequestMapping("/memberManager")
		public String memberManager(Model model,HttpSession session,PageVo pageVo,String keyword) {//????????? ??????????????? ????????????????????? ?????????.
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			if(keyword == null) {//?????? ???????????? ????????????
				map = memberService.memberPagingList(pageVo);
			}else {//?????????????????? ????????????
				Map<String , Object>keywordMap = new HashMap<String, Object>();
				keywordMap.put("keyword",keyword);
				keywordMap.put("page",pageVo.getPage());
				keywordMap.put("pageSize",pageVo.getPageSize());
				
				map = memberService.searchTitle(keywordMap);
				model.addAttribute("keyword",keyword);
			}
			
			List<MemberVo> memberList = (List<MemberVo>) map.get("memberList");
			int paginationSize = (int) map.get("paginationSize");
			
			Map<String, String> resultMap = new HashMap<String, String>();
			Map<String, String> resultMap2 = new HashMap<String, String>();
			
			for(MemberVo mem : memberList) {
				String name = memberService.getRegionName(mem.getRegion_cd());
				resultMap.put(mem.getMember_id(), name);
			}
			
			for(MemberVo mem : memberList) {
				if(mem.getTob_cd()!=null) {
				String tob_name = memberService.getTobName(mem.getTob_cd());
				logger.debug("tob_name : {}",tob_name);
				resultMap2.put(mem.getMember_id(), tob_name);
				}
			}
			
			model.addAttribute("memberList",memberList);
			model.addAttribute("paginationSize", paginationSize);
			model.addAttribute("pageVo", pageVo);
			model.addAttribute("region_name", resultMap);
			model.addAttribute("region_name2", resultMap2);
			
			return "tiles.memberManager";
		}
		
		@RequestMapping(path ="/memberManager",method = RequestMethod.POST)
		public String memberManager(Model model, String member_id,HttpSession session) {//????????? ??????????????? ????????????????????? ?????????.
			
			MemberVo mv = memberService.getMemberInfo(member_id);
			logger.debug("@@@@@@@@@@@@mv : {}",mv);
			logger.debug("##################grade : {}",mv.getMember_grade());
			
			List<MemberVo> memList = memberService.memberList();
			Map<String, String> resultMap = new HashMap<String, String>();
			Map<String, String> resultMap2 = new HashMap<String, String>();
			
			for(MemberVo mem : memList) {
				String name = memberService.getRegionName(mem.getRegion_cd());
				resultMap.put(mem.getMember_id(), name);
			}
			
			for(MemberVo mem : memList) {
				if(mem.getTob_cd()!=null) {
				String tob_name = memberService.getTobName(mem.getTob_cd());
				logger.debug("tob_name : {}",tob_name);
				resultMap2.put(mem.getMember_id(), tob_name);
				}
			}

			memberService.memberFire(member_id);
			model.addAttribute("region_name", resultMap);
			model.addAttribute("region_name2", resultMap2);
			model.addAttribute("memberList",memberService.memberList());
			
			
			return "redirect:/memberManager";
		}
		
		@RequestMapping(path="/memberSearch")
		public String memberSearch(Model model, String keyword,HttpSession session,PageVo pageVo) {
			
			if(keyword==null) {
				 memberService.memberPagingList(pageVo);
			}
			
			List<MemberVo> memList = memberService.memberList();
			Map<String, String> resultMap = new HashMap<String, String>();
			Map<String, String> resultMap2 = new HashMap<String, String>();
			
			for(MemberVo mem : memList) {
				String name = memberService.getRegionName(mem.getRegion_cd());
				resultMap.put(mem.getMember_id(), name);
			}
			
			for(MemberVo mem : memList) {
				if(mem.getTob_cd()!=null) {
				String tob_name = memberService.getTobName(mem.getTob_cd());
				logger.debug("tob_name : {}",tob_name);
				resultMap2.put(mem.getMember_id(), tob_name);
				}
			}
			
			model.addAttribute("region_name", resultMap);
			model.addAttribute("region_name2", resultMap2);
			
			model.addAttribute("memberSelectList",memberService.memberSearch(keyword));
			
			
			return "tiles.memberSearch";
			
		}
		
		//=================================================================================

	
	@RequestMapping("/register")
	
	public String register(Model model) {
		
		List<RegionVo> rList = new ArrayList<RegionVo>();
		RegionVo rVo = new RegionVo();
		rList = tobRecomService.getRegion();
		MemberVo memberVo = new MemberVo();
		
		
		if (memberVo.getRegion_cd() != 0)
			rVo = tobRecomService.getInterestRegion(memberVo.getMember_id());

		model.addAttribute("regionList", rList);
		model.addAttribute("interestRegion", rVo);
		
		//?????????(???/???/???) ????????? ????????????
		model.addAttribute("TopTobList", bdAnalysisService.getAllTopTobList());
		model.addAttribute("BotTobList", bdAnalysisService.getAllBotTobList());
		
		
		logger.debug("TopTobList : {}",bdAnalysisService.getAllTopTobList());
		logger.debug("MidTobList : {}",bdAnalysisService.getAllMidTobList());
		logger.debug("BotTobList : {}",bdAnalysisService.getAllBotTobList());
		
		return "member/register";
	}
	
	@RequestMapping("/idCheck")
	public String idCheck(Model model, String Member_id) {
		logger.debug("member_id : {}",Member_id);
		
		return "member/IdCheckForm";
	}
	
	// ------------- ?????? api --------------------
	
	@RequestMapping(path = "/captcha")
	public String captchaView() {
		logger.debug("captcha access..");
		return "member/signup";
	}
	
	
	
	String clientId = "KA0JLCbc99r5G2LwMRaT";//?????????????????? ??????????????? ????????????";
	String clientSecret = "ZVVBQXzjMC";//?????????????????? ??????????????? ????????????";
	
	
	@RequestMapping(path="/tob", method=RequestMethod.POST)
	public String tob(Model model,String tob_cd2) {
		
		logger.debug("tob_cd2 : {}",tob_cd2);
		model.addAttribute("midList",tobRecomService.getMidList(tob_cd2));
		logger.debug("tobRecomService.getMidList(tob_cd2): {}",tobRecomService.getMidList(tob_cd2).size());
		return "jsonView";
	}
	
	@RequestMapping(path = "/captchaNkey")
	public String CaptchaNkey(Model model) {
		logger.debug("captcha ????????? ??????.. ");
		String result="";
		try {
			String code = "0"; // ??? ????????? 0,  ?????? ????????? ????????? 1??? ??????
			String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // ?????? ??????
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // ?????? ??????
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			logger.debug("response.toString() : {}",response.toString());
			result = response.toString().substring(8, 8 + 16);
//			result = response.toString();
		} catch (Exception e) {
			System.out.println(e);
		}
		model.addAttribute("key",result);
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/captchaImage", method = RequestMethod.GET)
	public String CaptchaImage(Model model,String key,HttpServletRequest request ){
		logger.debug("captcha ????????? ??????..");
        String result = null;
        String dirPath = (String) request.getServletContext().getRealPath("/captchaImage");
        logger.debug("dirPath : {}" , dirPath);
        
        try {
            String apiURL = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
          
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // ?????? ??????
                InputStream is = con.getInputStream();
                int read = 0;
                byte[] bytes = new byte[1024];
                // ????????? ????????????  ?????? ??????
                String tempname = Long.valueOf(new Date().getTime()).toString();
                File f = new File(dirPath +File.separator+""+tempname + ".jpg");
                f.createNewFile();
                OutputStream outputStream = new FileOutputStream(f);
                
				while ((read = is.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
				result = tempname + ".jpg";
//				result = f.getAbsolutePath();
				outputStream.close();
				is.close();
  
            } else {  // ?????? ??????
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
                String inputLine;
                StringBuffer response = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    response.append(inputLine);
                }
                br.close();
                System.out.println(response.toString());
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        
        model.addAttribute("captchaImageName",result);
        return "jsonView";
		
	}
	
	@RequestMapping(path = "/captchaNkeyResult" )
	public String CaptchaNkeyResult(Model model,String key, String value) {
        try {
        	logger.debug("key: {}, value : {}", key, value);
            String code = "1"; // ??? ????????? 0,  ?????? ????????? ????????? 1??? ??????
            String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code +"&key="+ key + "&value="+ value;
            int result =0;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
          
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // ?????? ??????
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // ?????? ??????
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
//            System.out.println(response.toString());
            logger.debug("response : {}", response);
            int idx1 = response.indexOf(":");
            int idx2 = response.indexOf(",");
            model.addAttribute("result", response.substring(idx1+1, idx2));
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        return "jsonView";
		
	}
	
	
	
	/**
	 * Method : myPage
	 * ????????? : CHOEUNJU
	 * ???????????? :
	 * @return String
	 * Method ?????? : ??????????????? ?????? ??????
	 */
	@RequestMapping(path="/myPage", method=RequestMethod.GET)
	public String myPage(HttpSession session, Model model) {
		
		if(session.getAttribute("MESSAGE") != null) {
			model.addAttribute("MESSAGE", session.getAttribute("MESSAGE"));
			session.removeAttribute("MESSAGE");
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		if(memberVo == null) {
			session.setAttribute("MESSAGE", "???????????? ????????? ???????????????.");
			return "redirect:/login";
	
		} else {
			// ??? ????????? ????????????
			List<RegionVo> guList = bdAnalysisService.getGuList();
			model.addAttribute("guList", guList);
			
			// ?????? ????????? ????????? ????????????
			model.addAttribute("largeList", bdAnalysisService.getAllTopTobList());
			
			// ????????? ???????????? ???, ???, ???????????????
			TobVo tobVo = memberService.getInterestTob(memberVo.getMember_id());
			model.addAttribute("tobVo", tobVo);
			
			// ????????? ???????????? ???, ?????????
			RegionVo regionVo = memberService.getInterestRegion(memberVo.getMember_id());
			model.addAttribute("regionVo", regionVo);
			
			return "myPage/myPageList";
		}
	}
	
	/**
	 * Method : unlinkedSocial
	 * ????????? : CHOEUNJU
	 * ???????????? :
	 * @return String
	 * Method ?????? : ???????????????, ????????????????????? (ajax)
	 */
	@RequestMapping(path = "/unlinkedSocial", method = RequestMethod.POST)
	public String unlinkedSocial(String social, HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		Map<String, String> map = new HashMap<String, String>();
		String message = "";
		
		if(social.equals("MEMBER_NAVER_KEY")) {
			message = "NAVER";
		} else if(social.equals("MEMBER_KAKAO_KEY")) {
			message = "KAKAO";
		}
		
		map.put("column", social);
		map.put("data", null);
		map.put("member_id", memberVo.getMember_id());
		
		int cnt = memberService.linkSocial(map);
		
		if(cnt > 0) {
			model.addAttribute("result", message);
		} else {
			model.addAttribute("result", "FAIL");
		}
		
		return "jsonView";
	}
	
	/**
	 * Method : withdraw
	 * ????????? : CHOEUNJU
	 * ???????????? :
	 * @return String
	 * Method ?????? : ?????? ?????? ?????? (ajax)
	 */
	@RequestMapping(path="/withdraw", method = RequestMethod.POST)
	public String withdraw(HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		// ?????? ?????? ?????? ??? ???????????? ?????? ??????
		int cnt = memberService.withdrawMember(memberVo.getMember_id());
		
		// ???????????? ??? ???????????? ??????????????? ???????????? ?????? ?????? ??????
		if(cnt > 0) {
			session.invalidate();
			model.addAttribute("result", true);
		} else {
			model.addAttribute("result", false);
		}
		return "jsonView";
	}
	
	/**
	 * Method : checkPassword
	 * ????????? : CHOEUNJU
	 * ???????????? :
	 * @return String
	 * Method ?????? : ?????? ???????????? ????????? ??????????????? ??????????????? ?????? (ajax)
	 */
	@RequestMapping(path = "/checkPassword", method = RequestMethod.POST)
	public String checkPassword(String password, HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("MEMBER_INFO");
		
		String encryptPw = KISA_SHA256.encrypt(password);
		
		if(encryptPw.equals(memberVo.getMember_password())) {
			model.addAttribute("result", true);
		} else {
			model.addAttribute("result", false);
		}
		
		return "jsonView";
	}
	
	/**
	 * Method : modifyMember
	 * ????????? : CHOEUNJU
	 * ???????????? :
	 * @return String
	 * Method ?????? : ?????? ?????? ?????? ??????
	 */
	@RequestMapping(path="/modifyMember", method = RequestMethod.POST)
	public String modifyMember(MemberVo memberVo, HttpSession session, Model model) {
		logger.debug("??? memberVo : {}", memberVo);
		
		String password = memberVo.getMember_password();
		String encryptPw = KISA_SHA256.encrypt(password);
		
		memberVo.setMember_password(encryptPw);
		
		int cnt = memberService.modifyMember(memberVo);
		
		if(cnt > 0) {
			session.setAttribute("MEMBER_INFO", memberService.getMemberInfo(memberVo.getMember_id()));
			session.setAttribute("MESSAGE", "success");
		} else {
			session.setAttribute("MESSAGE", "fail");
		}
		
		return "redirect:/myPage";
	}
}

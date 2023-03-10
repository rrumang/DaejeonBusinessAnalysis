package kr.or.ddit.support.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.support.model.ItemsVo;

@RequestMapping("/support")
@Controller
public class supportController {
	/**
	 * 
	* Method : policyList
	* 작성자 : 유민하
	* 변경이력 :
	* @param model
	* @return
	* Method 설명 : 해당 지원시책 내용을 출력
	 */
	@RequestMapping(path="/supportList")
	public String policyList(Model model) {
		List<ItemsVo> policyList = Support.policy();          //정책자금
		List<ItemsVo> growthList = Support.growth();          //성장지원
		List<ItemsVo> comebackList = Support.comeback();      //재기지원
		List<ItemsVo> foundationList = Support.foundation();  //창업지원
		List<ItemsVo> marketList = Support.market();          //전통시장 활성화
		List<ItemsVo> guaranteeList = Support.guarantee();    //보증지원
		
		model.addAttribute("policyList",policyList);
		model.addAttribute("growthList",growthList);
		model.addAttribute("comebackList",comebackList);
		model.addAttribute("foundationList",foundationList);
		model.addAttribute("marketList",marketList);
		model.addAttribute("guaranteeList",guaranteeList);
		
		return "support/supportList";
	}
}

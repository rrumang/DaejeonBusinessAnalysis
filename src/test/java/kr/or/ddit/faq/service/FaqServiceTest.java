package kr.or.ddit.faq.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import kr.or.ddit.faq.model.FaqVo;
import kr.or.ddit.testenv.LogicTestEnv;

public class FaqServiceTest extends LogicTestEnv {

	@Resource(name="faqService")
	private IFaqService faqService;

	/**
	 * 
	 * Method : test
	 * 작성자 : PC08
	 * 변경이력 :
	 * Method 설명 : 전체 faq게시글 조회 테스트
	 */
	@Test
	public void faqListTest() {
		/***Given***/
		/***When***/
		List<FaqVo> faqList = faqService.faqList();

		/***Then***/
		assertEquals("테스트1", faqList.get(0).getFaq_title());
	}

	/**
	 * 
	 * Method : getFaqTest
	 * 작성자 : PC08
	 * 변경이력 :
	 * Method 설명 : 특정 faq게시글 조회 테스트
	 */
	@Test
	public void getFaqTest() {
		/***Given***/
		String faq_cd = "1";

		/***When***/
		FaqVo faqVo = faqService.getFaq(faq_cd);

		/***Then***/
		assertEquals("테스트1", faqVo.getFaq_title());
	}

	/**
	 * 
	 * Method : insertFaqTest
	 * 작성자 : PC08
	 * 변경이력 :
	 * Method 설명 : faq게시글 등록 테스트
	 */
	@Test
	public void insertFaqTest() {
		/***Given***/
		FaqVo faqVo = new FaqVo("2", "테스트2", "내용2", 1);

		/***When***/
		int insertCnt = faqService.insertFaq(faqVo);

		/***Then***/
		assertEquals(1, insertCnt);
	}

	/**
	 * 
	 * Method : deleteFaqTest
	 * 작성자 : PC08
	 * 변경이력 :
	 * Method 설명 : faq게시글 삭제 테스트
	 */
	@Test
	public void deleteFaqTest() {
		/***Given***/
		String faq_cd = "1";

		/***When***/
		int deleteCnt = faqService.deleteFaq(faq_cd);

		/***Then***/
		assertEquals(1, deleteCnt);
	}

	@Test
	public void updateFaqTest() {
		/***Given***/
		FaqVo faqVo = new FaqVo("1", "테스트1","내용1",1);

		/***When***/
		int updateCnt = faqService.updateFaq(faqVo);

		/***Then***/
		assertEquals(1, updateCnt);
	}

}

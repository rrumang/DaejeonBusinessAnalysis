package kr.or.ddit.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.notice.dao.INoticeDao;
import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.paging.model.PageVo;

@Service
public class NoticeService implements INoticeService {
	
	@Resource(name="noticeDao")
	private INoticeDao dao;
	
	@Override
	public Map<String, Object> getAllNotice(PageVo pageVo) {
		List<NoticeVo> noticeList = dao.getAllNotice(pageVo);
		int allCnt = dao.getAllCnt();
		int paginationSize = (int) Math.ceil((double) allCnt / pageVo.getPageSize());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("noticeList", noticeList);
		
		return resultMap;
	}

	@Override
	public NoticeVo getNotice(String notice_cd) {
		return dao.getNotice(notice_cd);
	}
	
	@Override
	public String insertNotice(NoticeVo noticeVo) {
		return dao.insertNotice(noticeVo);
	}

	@Override
	public int updateNotice(NoticeVo noticeVo) {
		return dao.updateNotice(noticeVo);
	}

	@Override
	public int updateStatus(String notice_cd) {
		return dao.updateStatus(notice_cd);
	}

	@Override
	public Map<String, Object> searchTitle(Map<String, Object> map) {
		List<NoticeVo> noticeList = dao.searchTitle(map);
		int cnt = dao.getSearchTitleCnt((String) map.get("notice_title"));
		int paginationSize = (int) Math.ceil((double) cnt / (int) map.get("pageSize"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("noticeList", noticeList);
		
		return resultMap;
	}

	@Override
	public List<NoticeVo> getNoticeMain() {
		return dao.getNoticeMain();
	}
}

package kr.or.ddit.notice.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.notice.model.NoticeVo;
import kr.or.ddit.paging.model.PageVo;

@Repository
public class NoticeDao implements INoticeDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<NoticeVo> getAllNotice(PageVo pageVo) {
		return sqlSession.selectList("notice.getAllNotice", pageVo);
	}

	@Override
	public int getAllCnt() {
		return sqlSession.selectOne("notice.getAllCnt");
	}

	@Override
	public NoticeVo getNotice(String notice_cd) {
		return sqlSession.selectOne("notice.getNotice", notice_cd);
	}

	@Override
	public String insertNotice(NoticeVo noticeVo) {
		sqlSession.insert("notice.insertNotice", noticeVo);
		return noticeVo.getNotice_cd();
	}

	@Override
	public int updateNotice(NoticeVo noticeVo) {
		return sqlSession.update("notice.updateNotice", noticeVo);
	}

	@Override
	public int updateStatus(String notice_cd) {
		return sqlSession.update("notice.updateStatus", notice_cd);
	}

	@Override
	public List<NoticeVo> searchTitle(Map<String, Object> map) {
		return sqlSession.selectList("notice.searchTitle", map);
	}

	@Override
	public int getSearchTitleCnt(String notice_title) {
		return sqlSession.selectOne("notice.getSearchTitleCnt", notice_title);
	}

	@Override
	public List<NoticeVo> getNoticeMain() {
		return sqlSession.selectList("notice.getNoticeMain");
	}

}

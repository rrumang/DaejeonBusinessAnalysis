package kr.or.ddit.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.freeBoard.dao.IFreeBoardDao;
import kr.or.ddit.freeBoard.model.CommentVo;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;

@Service
public class FreeBoardService implements IFreeBoardService {

	@Resource(name="freeBoardDao")
	private IFreeBoardDao fboardDao;
	
	@Override
	public List<FreeBoardVo> fBoardList() {
		return fboardDao.fBoardList();
	}

	@Override
	public int insertF_board(FreeBoardVo fVo) {
		return fboardDao.insertF_board(fVo);
	}

	@Override
	public FreeBoardVo getFreeBoard(String freeBoard_cd) {
		return fboardDao.getFreeBoard(freeBoard_cd);
	}

	@Override
	public int getFreedelete(String freeBoard_cd) {
		return fboardDao.getFreedelete(freeBoard_cd);
	}

	@Override
	public int getFreeUpdate(FreeBoardVo fv) {
		return fboardDao.getFreeUpdate(fv);
	}

	@Override
	public List<CommentVo> getComList(String freeboard_cd) {
		return fboardDao.getComList(freeboard_cd);
	}

	@Override
	public int getInsertCommnet(CommentVo cv) {
		return fboardDao.getInsertCommnet(cv);
	}

	@Override
	public List<FreeBoardVo> getMainFreeboard() {
		return fboardDao.getMainFreeboard();
	}

	@Override
	public int getDeleteComment(String comment_cd) {
		return fboardDao.getDeleteComment(comment_cd);
	}

	@Override
	public List<FreeBoardVo> getSearchFreeBoard(String keyword) {
		return fboardDao.getSearchFreeBoard(keyword);
	}

	@Override
	public Map<String, Object> getAllFreeboard(PageVo pageVo) {
		List<FreeBoardVo> freeboardList = fboardDao.getAllFreeBoard(pageVo);
		int allCnt = fboardDao.getAllFreeBoardCount();
		int paginationSize = (int) Math.ceil((double)allCnt/pageVo.getPageSize());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("freeboardList", freeboardList);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> searchTitle(Map<String, Object> map) {
		List<FreeBoardVo> freeboardList = fboardDao.getKeywordFreeboard(map);
		int Cnt = fboardDao.getKeywordFreeCnt((String)map.get("keyword"));
		int paginationSize = (int) Math.ceil((double)Cnt/(int)map.get("pageSize"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("freeboardList", freeboardList);
		
		return resultMap;
	}

	
	
}

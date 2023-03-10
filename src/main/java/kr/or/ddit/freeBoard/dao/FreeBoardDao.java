package kr.or.ddit.freeBoard.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.freeBoard.model.CommentVo;
import kr.or.ddit.freeBoard.model.FreeBoardVo;
import kr.or.ddit.paging.model.PageVo;



@Repository
public class FreeBoardDao implements IFreeBoardDao {

	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<FreeBoardVo> fBoardList() {
		return sqlSession.selectList("board.getAllFreeBoard");
	}

	@Override
	public int insertF_board(FreeBoardVo fVo) {
		return sqlSession.insert("board.insertFreeBoard", fVo);
	}

	@Override
	public FreeBoardVo getFreeBoard(String freeBoard_cd) {
		return sqlSession.selectOne("board.getFreeBoard",freeBoard_cd);
	}

	@Override
	public int getFreedelete(String freeBoard_cd) {
		return sqlSession.update("board.getFreedel",freeBoard_cd);
	}

	@Override
	public int getFreeUpdate(FreeBoardVo fv) {
		return sqlSession.update("board.getFreeModify",fv);
	}

	@Override
	public List<CommentVo> getComList(String freeboard_cd) {
		return sqlSession.selectList("commnet.getCommnet",freeboard_cd);
	}

	@Override
	public int getInsertCommnet(CommentVo cv) {
		return sqlSession.insert("commnet.insertCom",cv);
	}

	@Override
	public List<FreeBoardVo> getMainFreeboard() {
		return sqlSession.selectList("board.getMainFreeBoard");
	}

	@Override
	public int getDeleteComment(String comment_cd) {
		return sqlSession.update("commnet.getDeleteCom",comment_cd);
	}

	@Override
	public List<FreeBoardVo> getSearchFreeBoard(String keyword) {
		return sqlSession.selectList("board.getFreeboardSearch",keyword);
	}

	@Override
	public int getAllFreeBoardCount() {
		return sqlSession.selectOne("board.getFreeboardCount");
	}

	@Override
	public int getKeywordFreeCnt(String keyword) {
		return sqlSession.selectOne("board.getKeywordFreeCnt",keyword);
	}

	@Override
	public List<FreeBoardVo> getAllFreeBoard(PageVo pageVo) {
		return sqlSession.selectList("board.getPagingFreeBoard",pageVo);
	}

	@Override
	public List<FreeBoardVo> getKeywordFreeboard(Map<String, Object> map) {
		return sqlSession.selectList("board.getKeywordPagingFreeBoard",map);
	}
	
	
}

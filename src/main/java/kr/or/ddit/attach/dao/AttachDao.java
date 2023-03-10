package kr.or.ddit.attach.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.ddit.attach.model.AttachVo;

@Repository
public class AttachDao implements IAttachDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AttachVo> getAttachList(Map<String, String> map) {
		return sqlSession.selectList("attach.getAttachList", map);
	}

	@Override
	public AttachVo getAttach(String attach_cd) {
		return sqlSession.selectOne("attach.getAttach", attach_cd);
	}

	@Override
	public int insertAttach(AttachVo attachVo) {
		return sqlSession.insert("attach.insertAttach", attachVo);
	}

	@Override
	public int deleteAttach(String attach_cd) {
		return sqlSession.delete("attach.deleteAttach", attach_cd);
	}

	@Override
	public int updateStatusY(String attach_cd) {
		return sqlSession.update("attach.updateStatusY", attach_cd);
	}

	@Override
	public int updateStatusN(String attach_cd) {
		return sqlSession.update("attach.updateStatusN", attach_cd);
	}

	@Override
	public List<AttachVo> getAttachListY(Map<String, String> map) {
		return sqlSession.selectList("attach.getAttachListY", map);
	}

}

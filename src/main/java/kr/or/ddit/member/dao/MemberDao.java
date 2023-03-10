package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Repository
public class MemberDao implements IMemberDao {
	
	@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession;

	
	private static final Logger logger = LoggerFactory.getLogger(MemberDao.class);

	
	@Override
	public int insertMember(MemberVo memberVo) {
		
		return sqlSession.insert("member.insertMember",memberVo);
	}

	@Override
	public int getMember(String member_id) {
		return sqlSession.selectOne("member.getMember",member_id);
	}

	@Override
	public List<MemberVo> memberList() {
		return sqlSession.selectList("member.getAllMember");
	}
	
	@Override
	public int memberFire(String member_id) {
		return sqlSession.update("member.memberFire",member_id);
	}

	@Override
	public List<MemberVo> memberSearch(String keyword) {
		
		return sqlSession.selectList("member.memberSearch",keyword);
	}

	// =============================================================
	
	@Override
	public MemberVo normalLogin(Map<String, String> map) {
		return sqlSession.selectOne("member.normalLogin", map);
	}

	@Override
	public int linkSocial(Map<String, String> map) {
		logger.debug("▶ map : {} ", map);
		return sqlSession.update("member.linkSocial", map);
	}

	@Override
	public MemberVo getFindingId(MemberVo memberVo) {
		return sqlSession.selectOne("member.getFindingId", memberVo);
	}

	@Override
	public MemberVo getMemberInfo(String member_id) {
		return sqlSession.selectOne("member.getMemberInfo", member_id);
	}

	@Override
	public int modifyMember(MemberVo memberVo) {
		return sqlSession.update("member.modifyMember", memberVo);
	}
	
	@Override
	public TobVo getInterestTob(String member_id) {
		return sqlSession.selectOne("member.getInterestTob", member_id);
	}

	@Override
	public RegionVo getInterestRegion(String member_id) {
		return sqlSession.selectOne("member.getInterestRegion", member_id);
	}

	@Override
	public int withdrawMember(String member_id) {
		return sqlSession.update("member.withdrawMember", member_id);
	}
	
	@Override
	public String getRegionName(Long region_cd) {
		return sqlSession.selectOne("member.region_name",region_cd);
	}

	@Override
	public String getTobName(String tob_cd) {
		return sqlSession.selectOne("member.tob_name",tob_cd);
	}

	@Override
	public List<MemberVo> memberPagingList(PageVo pv) {
		return sqlSession.selectList("member.paging_member",pv);
	}

	
	@Override
	public int getAllMemberCount() {
		return sqlSession.selectOne("member.allMemberCount");
	}

	@Override
	public int getMemberCountKeyword(String keyword) {
		return sqlSession.selectOne("member.kewordPaging",keyword);
	}

	@Override
	public List<MemberVo> searchTitle(Map<String, Object> map) {
		return sqlSession.selectList("member.keyword_paging_member",map);
	}

	@Override
	public int getSearchTitleCnt(String keyword) {
		return sqlSession.selectOne("member.getSearchTitleCnt",keyword);
	}

	

}

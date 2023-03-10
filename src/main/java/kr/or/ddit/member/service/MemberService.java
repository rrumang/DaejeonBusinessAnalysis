package kr.or.ddit.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.paging.model.PageVo;
import kr.or.ddit.select.model.RegionVo;
import kr.or.ddit.select.model.TobVo;

@Service
public class MemberService implements IMemberService {

	@Resource(name="memberDao")
	private IMemberDao memberDao;
	
	@Override
	public int insertMember(MemberVo memverVo) {
		return memberDao.insertMember(memverVo);
	}

	@Override
	public int getMember(String member_id) {
		return memberDao.getMember(member_id);
	}

	@Override
	public List<MemberVo> memberList() {
		return memberDao.memberList();
	}

	@Override
	public int memberFire(String member_id) {
		return memberDao.memberFire(member_id);
	}

	@Override
	public List<MemberVo> memberSearch(String keyword) {
		return memberDao.memberSearch(keyword);
	}

	// =====================================================================
	
	@Override
	public MemberVo normalLogin(Map<String, String> map) {
		return memberDao.normalLogin(map);
	}

	@Override
	public int linkSocial(Map<String, String> map) {
		return memberDao.linkSocial(map);
	}

	@Override
	public MemberVo getFindingId(MemberVo memberVo) {
		return memberDao.getFindingId(memberVo);
	}
	
	@Override
	public MemberVo getMemberInfo(String member_id) {
		return memberDao.getMemberInfo(member_id);
	}

	@Override
	public int modifyMember(MemberVo memberVo) {
		return memberDao.modifyMember(memberVo);
	}

	@Override
	public TobVo getInterestTob(String member_id) {
		return memberDao.getInterestTob(member_id);
	}

	@Override
	public RegionVo getInterestRegion(String member_id) {
		return memberDao.getInterestRegion(member_id);
	}
	
	@Override
	public int withdrawMember(String member_id) {
		return memberDao.withdrawMember(member_id);
	}

	@Override
	public String getRegionName(Long region_cd) {
		return memberDao.getRegionName(region_cd);
	}

	@Override
	public String getTobName(String tob_cd) {
		return memberDao.getTobName(tob_cd);
	}

	@Override
	public Map<String, Object> memberPagingList(PageVo pv) {
		List<MemberVo> memberList = memberDao.memberPagingList(pv);
		int memberCount  =memberDao.getAllMemberCount();
		int paginationSize = (int) Math.ceil((double) memberCount / pv.getPageSize());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("memberList",memberList);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> searchTitle(Map<String, Object> map) {
		List<MemberVo> memberList = memberDao.searchTitle(map);
		int cnt = memberDao.getSearchTitleCnt((String)map.get("keyword"));
		int paginationSize = (int)Math.ceil((double)cnt / (int)map.get("pageSize"));
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paginationSize", paginationSize);
		resultMap.put("memberList", memberList);
		
		return resultMap;
	}

}

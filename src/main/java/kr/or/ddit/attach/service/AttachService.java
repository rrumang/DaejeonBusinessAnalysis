package kr.or.ddit.attach.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.attach.dao.IAttachDao;
import kr.or.ddit.attach.model.AttachVo;

@Service
public class AttachService implements IAttachService {

	@Resource(name="attachDao")
	private IAttachDao dao;
	
	@Override
	public List<AttachVo> getAttachList(Map<String, String> map) {
		return dao.getAttachList(map);
	}

	@Override
	public AttachVo getAttach(String attach_cd) {
		return dao.getAttach(attach_cd);
	}

	@Override
	public int insertAttach(AttachVo attachVo) {
		return dao.insertAttach(attachVo);
	}

	@Override
	public int deleteAttach(String attach_cd) {
		return dao.deleteAttach(attach_cd);
	}

	@Override
	public int updateStatusY(String attach_cd) {
		return dao.updateStatusY(attach_cd);
	}

	@Override
	public int updateStatusN(String attach_cd) {
		return dao.updateStatusN(attach_cd);
	}

	@Override
	public List<AttachVo> getAttachListY(Map<String, String> map) {
		return dao.getAttachListY(map);
	}

}

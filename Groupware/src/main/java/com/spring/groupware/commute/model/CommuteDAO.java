package com.spring.groupware.commute.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.groupware.addrlist.model.AddrGroupVO;
import com.spring.groupware.member.model.MemberVO;

@Component
@Repository
public class CommuteDAO implements InterCommuteDAO {	
	
	@Resource
	private SqlSessionTemplate sqlsession; // 로컬 DB에 연결

	@Resource
	private SqlSessionTemplate sqlsession2; // 원격 DB에 연결
	
	@Resource
	private SqlSessionTemplate sqlsession3; // 로컬 DB에 hr로 연결

	@Override
	public List<String> cmtList(String sysdate) {
		List<String> cmtList = sqlsession.selectList("commute.cmtListWithPaging", sysdate);		
		return cmtList;
	}

	



}

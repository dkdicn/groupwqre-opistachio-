package com.spring.groupware.sns.service;

import java.util.List;
import java.util.Map;


import com.spring.groupware.member.model.MemberVO;
import com.spring.groupware.sns.model.TalkroomVO;

public interface IntersnsMemberService {

	// 유저목록 불러오기
	List<MemberVO> getmemberList();

	// 검색어가 있는 유저목록 불러오기
	List<MemberVO> memberListSearch(Map<String, String> paraMap);

	// 정보수정하기
	int infochange(MemberVO membervo);

	// 상태수정하기
	int statuschange(MemberVO membervo);

	/*
	 * // 채팅방 리스트가져오기 List<TalkroomVO> getTalkroomlist(String fk_mbr_id);
	 */

	// 접속시 유저 온라인 상태로 만들기
	int onlinestatus(MemberVO membervo);

	


	
}

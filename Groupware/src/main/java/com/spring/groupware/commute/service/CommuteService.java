package com.spring.groupware.commute.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


import com.spring.groupware.commute.model.InterCommuteDAO;

@Component
@Service
public class CommuteService implements InterCommuteService {

	@Autowired
	private InterCommuteDAO cdao;

	@Override
	public List<String> cmtListWithPaging(String sysdate) {
		List<String> cmtList = cdao.cmtList(sysdate);
	    return cmtList;
	}
	

	
}

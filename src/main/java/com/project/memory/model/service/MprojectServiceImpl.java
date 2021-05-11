package com.project.memory.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.memory.model.dao.MprojectMapper;
import com.project.memory.model.vo.Keyword;
import com.project.memory.model.vo.Question;

@Service
public class MprojectServiceImpl implements MprojectService {

	@Autowired
	private MprojectMapper mapper;

	@Override
	public List<Question> selectQuestion() {
		// TODO Auto-generated method stub
		return mapper.selectQuestion();
	}

	@Override
	public List<Keyword> selectKeyword() {
		// TODO Auto-generated method stub
		return mapper.selectKeyword();
	}

}

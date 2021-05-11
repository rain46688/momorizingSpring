package com.project.memory.model.service;

import java.util.List;

import com.project.memory.model.vo.Keyword;
import com.project.memory.model.vo.Question;

public interface MprojectService {

	List<Question> selectQuestion();

	List<Keyword> selectKeyword();

}

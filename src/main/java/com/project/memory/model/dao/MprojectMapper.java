package com.project.memory.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.project.memory.model.vo.Question;

@Mapper
public interface MprojectMapper {

	@Select("SELECT * FROM question")
	List<Question> selectQuestion();

}

package com.project.memory.controller;

import java.util.List;

import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.memory.model.service.MprojectService;
import com.project.memory.model.vo.Question;
import com.project.memory.model.vo.ResultVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	private MprojectService service;

	@RequestMapping("/")
	public ModelAndView test() {

		log.info("controller");
		List<Question> q = service.selectQuestion();

		ModelAndView mv = new ModelAndView("index");

		for (Question qu : q) {
			log.info("리스트 : " + qu);
		}

		mv.addObject("quList", q);
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/re", method = RequestMethod.POST)
	public String result(@RequestParam String resultarray) {
		log.info("re 실행");
		log.info("json : " + resultarray);
		ObjectMapper objectMapper = new ObjectMapper();
		List<ResultVo> list = null;
		List<Keyword> list = null;
		String result = "";
		try {
			list = objectMapper.readValue(resultarray, new TypeReference<List<ResultVo>>() {
			});

			for (ResultVo re : list) {
				log.info("ObjectArray : " + re);
			}
			result = objectMapper.writeValueAsString(list);
		} catch (JsonMappingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		return result;
	}

}

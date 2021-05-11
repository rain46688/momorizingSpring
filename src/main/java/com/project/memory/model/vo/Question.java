package com.project.memory.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Question {
	private int mid;
	private String mquestion;
	private boolean mmark;
	private int right_answer_count;
	private int answer_count;
}

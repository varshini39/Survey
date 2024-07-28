package org.survey.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class QuestionDTO {
    private Long id;
    private String text;
    private List<OptionDTO> options;

    // Getters and Setters - configured through lombok
}


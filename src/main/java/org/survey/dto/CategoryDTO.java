package org.survey.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CategoryDTO {
    private String surveyTitle;
    private String surveyDescription;
    private String categoryDescription;
    private List<QuestionDTO> questions;

    public CategoryDTO(String surveyTitle, String surveyDescription, String categoryDescription, List<QuestionDTO> questions) {
        this.surveyTitle = surveyTitle;
        this.surveyDescription = surveyDescription;
        this.categoryDescription = categoryDescription;
        this.questions = questions;
    }

    // Getters and setters - configured by lombok
}

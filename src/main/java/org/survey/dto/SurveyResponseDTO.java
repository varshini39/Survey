package org.survey.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SurveyResponseDTO {

    private Long userId;
    private Long questionId;
    private Long answerId; // Optional, if you're accepting pre-defined answers
    private String textResponse; // If you're allowing textual responses

    // Getters and Setters - configured by lombok
}
package org.survey.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseDTO {
    private Long questionId;
    private Long answerId; // Assuming an answer ID is expected, not a text response
    private Long userId;

    // Getters and Setters - configured through lombok
}

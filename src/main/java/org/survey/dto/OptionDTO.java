package org.survey.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OptionDTO {
    private Long id;
    private String text;

    // Constructors, getters, and setters
    public OptionDTO(Long id, String text) {
        this.id = id;
        this.text = text;
    }

    // Getters and Setters - configured through lombok
}

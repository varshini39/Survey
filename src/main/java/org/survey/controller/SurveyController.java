package org.survey.controller;

import org.springframework.stereotype.Controller;
import org.survey.dto.CategoryDTO;
import org.survey.dto.QuestionDTO;
import org.survey.dto.ResponseDTO;
import org.survey.service.SurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/surveys")
public class SurveyController {

    @Autowired
    private SurveyService surveyService;

    @GetMapping
    public String redirectToHome() {
        return "redirect:/home.html";
    }

    @GetMapping("/all")
    public ResponseEntity<List<CategoryDTO>> getAllSurveysWithDetails() {
        List<CategoryDTO> surveyDetails = surveyService.getAllSurveyDetails(); // Assumes implementation in SurveyService
        return ResponseEntity.ok(surveyDetails);
    }

    @GetMapping("/{categoryCode}/questions")
    public ResponseEntity<List<QuestionDTO>> getQuestionsByCategory(@PathVariable String categoryCode) {
        List<QuestionDTO> questions = surveyService.getQuestionsByCategory(categoryCode);
        return ResponseEntity.ok(questions);
    }

    @PostMapping("/submit")
    public ResponseEntity<String> submitResponses(@RequestBody List<ResponseDTO> responses) {
        if (surveyService.saveResponses(responses)) {
            return ResponseEntity.ok("Responses submitted successfully");
        } else {
            return ResponseEntity.badRequest().body("Failed to submit responses");
        }
    }
}

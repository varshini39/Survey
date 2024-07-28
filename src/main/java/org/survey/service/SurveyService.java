package org.survey.service;

import org.survey.dto.OptionDTO;
import org.survey.dto.QuestionDTO;
import org.survey.dto.ResponseDTO;
import org.survey.dto.CategoryDTO;
import org.survey.model.Question;
import org.survey.model.Response;
import org.survey.model.Survey;
import org.survey.model.User;
import org.survey.repository.QuestionRepository;
import org.survey.repository.ResponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.survey.repository.SurveyRepository;
import org.survey.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SurveyService {

    @Autowired
    private SurveyRepository surveyRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ResponseRepository responseRepository;

    public List<CategoryDTO> getAllSurveyDetails() {
        return surveyRepository.findAll().stream()
                .map(this::convertToCategoryDTO)
                .collect(Collectors.toList());
    }

    private CategoryDTO convertToCategoryDTO(Survey survey) {
        List<QuestionDTO> questionDTOs = questionRepository.findAllBySurveyId(survey.getId())
                .stream()
                .map(this::convertToQuestionDTO)
                .collect(Collectors.toList());

        return new CategoryDTO(
                survey.getTitle(),
                survey.getDescription(),
                survey.getCategory().getDescription(), // Ensure the Category entity has a getDescription() method
                questionDTOs
        );
    }

    public List<QuestionDTO> getQuestionsByCategory(String categoryCode) {
        return questionRepository.findAllByCategoryCode(categoryCode)
                .stream()
                .map(this::convertToQuestionDTO)
                .collect(Collectors.toList());
    }

    private QuestionDTO convertToQuestionDTO(Question question) {
        QuestionDTO dto = new QuestionDTO();
        dto.setId(question.getId());
        dto.setText(question.getText());
        dto.setOptions(question.getAnswers().stream()
                .map(answer -> new OptionDTO(answer.getId(), answer.getText()))
                .collect(Collectors.toList()));
        return dto;
    }

    public boolean saveResponses(List<ResponseDTO> responses) {
        try {
            responses.forEach(this::saveResponse);
            return true;
        } catch (Exception e) {
            System.out.println("Failed to save responses: " + e.getMessage());
            return false;
        }
    }

    private void saveResponse(ResponseDTO responseDTO) {
        Response response = new Response();
        Question question = questionRepository.findById(responseDTO.getQuestionId())
                .orElseThrow(() -> new IllegalStateException("Question not found"));
        User user = userRepository.findById(responseDTO.getUserId())
                .orElseThrow(() -> new IllegalStateException("User not found"));

        response.setQuestion(question);
        response.setAnswerId(responseDTO.getAnswerId());
        response.setUser(user); // Link the user, not the userId

        responseRepository.save(response);
    }

}

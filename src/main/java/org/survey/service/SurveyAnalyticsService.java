package org.survey.service;

import org.survey.model.Question;
import org.survey.model.Response;
import org.survey.repository.AnswerRepository;
import org.survey.repository.QuestionRepository;
import org.survey.repository.ResponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.AbstractMap;

@Service
public class SurveyAnalyticsService {

    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ResponseRepository responseRepository;
    @Autowired
    private AnswerRepository answerRepository;

    // Rate users by correct answers in the "KNW" category
    public Map<String, Long> rateUsersByKnowledge() {
        List<Question> questions = questionRepository.findAllByCategoryCode("KNW");
        Map<Long, Long> correctAnswers = questions.stream()
                .filter(question -> question.getCorrectAnswer() != null)
                .collect(Collectors.toMap(Question::getId, question -> question.getCorrectAnswer().getId()));

        List<Long> questionIds = questions.stream().map(Question::getId).collect(Collectors.toList());
        List<Response> responses = responseRepository.findAllByQuestionIdIn(questionIds);

        return responses.stream()
                .filter(response -> correctAnswers.containsKey(response.getQuestion().getId()) &&
                        response.getAnswerId().equals(correctAnswers.get(response.getQuestion().getId())))
                .collect(Collectors.groupingBy(response -> response.getUser().getName(), Collectors.counting()))
                .entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
                        (e1, e2) -> e1, LinkedHashMap::new)); // Collect to a map that preserves order
    }

    // Group and show statistics for the "OPN" category
    /*public Map<String, Map<String, Long>> groupOpinionResponses() {
        List<Question> questions = questionRepository.findAllByCategoryCode("OPN");
        if (questions.isEmpty()) {
            System.out.println("No questions found for OPN category.");
        }

        List<Long> questionIds = questions.stream().map(Question::getId).collect(Collectors.toList());
        List<Response> responses = responseRepository.findAllByQuestionIdIn(questionIds);
        if (responses.isEmpty()) {
            System.out.println("No responses found for question IDs.");
        }

        // Fetch all answers for these questions to map answerIds to text
        Map<Long, String> answerIdToTextMap = answerRepository.findAllById(questionIds.stream()
                        .flatMap(qId -> answerRepository.findByQuestionId(qId).stream())
                        .map(Answer::getId)
                        .collect(Collectors.toList()))
                .stream()
                .collect(Collectors.toMap(Answer::getId, Answer::getText));

        // Now group responses by question text and answer text using the map
        return responses.stream()
                .collect(Collectors.groupingBy(
                        response -> response.getQuestion().getText(),
                        Collectors.groupingBy(
                                response -> answerIdToTextMap.getOrDefault(response.getAnswerId(), "Unknown Answer"),
                                Collectors.counting()
                        )
                ));
    }*/

    public Map<String, LinkedHashMap<String, Double>> groupOpinionResponses() {
        List<Question> questions = questionRepository.findAllByCategoryCode("OPN");
        Map<Long, String> answerTextMap = new HashMap<>();

        // Assuming answerRepository provides answers by question ID
        questions.forEach(question -> answerRepository.findByQuestionId(question.getId())
                .forEach(answer -> answerTextMap.put(answer.getId(), answer.getText())));

        Map<String, LinkedHashMap<String, Double>> finalStats = new HashMap<>();

        for (Question question : questions) {
            // Use the new repository method
            List<Response> responses = responseRepository.findByQuestionId(question.getId());
            Map<Long, Long> counts = responses.stream()
                    .collect(Collectors.groupingBy(Response::getAnswerId, Collectors.counting()));

            long totalResponses = counts.values().stream().mapToLong(Long::longValue).sum();

            LinkedHashMap<String, Double> sortedPercentages = counts.entrySet().stream()
                    .map(entry -> new AbstractMap.SimpleEntry<>(
                            answerTextMap.get(entry.getKey()),  // Get text for answer ID
                            (entry.getValue() / (double) totalResponses) * 100.0))
                    .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
                    .collect(Collectors.toMap(
                            Map.Entry::getKey,
                            Map.Entry::getValue,
                            (e1, e2) -> e1, LinkedHashMap::new));

            finalStats.put(question.getText(), sortedPercentages);
        }

        return finalStats;
    }

}

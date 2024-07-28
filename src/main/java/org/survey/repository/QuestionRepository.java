package org.survey.repository;

import org.springframework.data.jpa.repository.Query;
import org.survey.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface QuestionRepository extends JpaRepository<Question, Long> {
    @Query("SELECT q FROM Question q WHERE q.survey.category.code = :categoryCode")
    List<Question> findAllByCategoryCode(String categoryCode);

    List<Question> findAllBySurveyId(Long surveyId);
}

package org.survey.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.survey.model.Survey;

public interface SurveyRepository extends JpaRepository<Survey, Long> {
    Survey findByCategoryCode(String categoryCode);
}

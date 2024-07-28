package org.survey.repository;

import org.survey.model.Response;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ResponseRepository extends JpaRepository<Response, Long> {
    List<Response> findAllByQuestionIdIn(List<Long> questionIds);
    List<Response> findByQuestionId(Long questionId);
}

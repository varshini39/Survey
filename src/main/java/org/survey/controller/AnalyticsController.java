package org.survey.controller;

import org.survey.service.SurveyAnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/analytics")
public class AnalyticsController {

    @Autowired
    private SurveyAnalyticsService surveyAnalyticsService;

    // Endpoint to get user ratings for the "KNW" category
    @GetMapping("/knw/ratings")
    public Map<String, Long> getKNWRatings() {
        return surveyAnalyticsService.rateUsersByKnowledge();
    }

    // Endpoint to get response statistics for the "OPN" category
    @GetMapping("/opn/statistics")
    public Map<String, LinkedHashMap<String, Double>> getOPNStatistics() {
        return surveyAnalyticsService.groupOpinionResponses();
    }
}

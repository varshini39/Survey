/*-- Insert KNW and OPN categories
INSERT INTO Category (code, description) VALUES
    ('KNW', 'Know Me – Questions about personal preferences and experiences'),
    ('OPN', 'Opinion – Questions assessing personal qualities and capabilities');

-- Insert a survey under the KNW category
INSERT INTO Survey (category_id, title, description) VALUES
    ((SELECT id FROM Category WHERE code = 'KNW'), 'Personal Knowledge Survey', 'A set of questions designed to see how well others know you.');

-- Insert a survey under the OPN category
INSERT INTO Survey (category_id, title, description) VALUES
    ((SELECT id FROM Category WHERE code = 'OPN'), 'Personality Assessment Survey', 'A set of questions to assess
  perceptions of your personal qualities and behaviors.');*/

/*-- Set the KNW survey_id
SET @survey_id = (SELECT id FROM Survey WHERE title = 'Personal Knowledge Survey');

-- 1. Insert the question about favorite color
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What is my favorite color?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Red'), (@question_id, 'Blue'), (@question_id, 'Green'), (@question_id, 'Black');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Blue' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 2. Insert the question about favorite sport
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What is my favorite sport?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Football'), (@question_id, 'Basketball'), (@question_id, 'Tennis'), (@question_id, 'Cricket');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Cricket' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 3. Insert the question about favorite cuisine
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What is my favorite cuisine?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Italian'), (@question_id, 'Chinese'), (@question_id, 'Indian'), (@question_id, 'Mexican');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Italian' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 4. Insert the question about favorite type of movie
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What is my favorite type of movie?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Comedy'), (@question_id, 'Horror'), (@question_id, 'Thriller'), (@question_id, 'Drama');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Thriller' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 5. Insert the question about go-to leisure activity
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What is my go-to leisure activity?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Reading'), (@question_id, 'Watching Sitcoms'), (@question_id, 'Gaming'), (@question_id, 'Cooking');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Reading' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 6. Insert question about alternate profession
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'If I did not become a software developer, what job would I pursue?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'RJ'), (@question_id, 'Detective'), (@question_id, 'Psychiatrist'), (@question_id, 'Teacher');
SET @answer_id_rj = (SELECT id FROM Answer WHERE text = 'RJ' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id_rj WHERE id = @question_id;

-- 7. Insert the question about the type of books I prefer
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What type of books do I prefer?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Fiction'), (@question_id, 'Non-fiction'), (@question_id, 'Science fiction'), (@question_id, 'Mystery');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Mystery' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 8. Insert the question about which season I like the most
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Which season do I like the most?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Spring'), (@question_id, 'Summer'), (@question_id, 'Autumn'), (@question_id, 'Winter');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Winter' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 9. Insert the question about my go-to comfort food
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'What''s my go-to comfort food?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Pizza'), (@question_id, 'Ice Cream'), (@question_id, 'Sushi'), (@question_id, 'Chocolate');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Ice Cream' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;

-- 10. Insert the question about which place I would love to travel
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Which place would I love to travel?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Japan'), (@question_id, 'Thailand'), (@question_id, 'Paris'), (@question_id, 'Turkey');
SET @answer_id = (SELECT id FROM Answer WHERE text = 'Paris' AND question_id = @question_id);
UPDATE Question SET correct_answer_id = @answer_id WHERE id = @question_id;
*/

-- Set the OPN survey_id
SET @survey_id = (SELECT id FROM Survey WHERE title = 'Personality Assessment Survey');

-- 1. Insert the question about handling criticism
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Do you think I handle criticism well?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 2. Insert the question about making new friends
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Am I good at making new friends?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 3. Insert the question about adaptability
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Am I adaptable to new situations?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 4. Insert the question about sense of humor
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Do I have a good sense of humor?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 5. Insert the question about reliability
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Do you think I am reliable?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 6. Insert the question about organization in work
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'Am I organized in my work?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Definitely'), (@question_id, 'Most Likely'), (@question_id, 'Moderate'), (@question_id, 'Least Likely'), (@question_id, 'Not at all');

-- 7. Insert the question about effectiveness of advice
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'How effective do you find my advice in difficult situations?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Extremely effective'), (@question_id, 'Very effective'), (@question_id, 'Moderately effective'), (@question_id, 'Slightly effective'), (@question_id, 'Not effective at all');

-- 8. Insert the question about handling stress
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'How do you rate my ability to handle stress?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Thrives under stress'), (@question_id, 'Manages well under stress'), (@question_id, 'Coping adequately under stress'), (@question_id, 'Struggles with stress'), (@question_id, 'Overwhelmed by stress');

-- 9. Insert the question about empathy
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'How would you rate my empathy towards others?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Highly empathetic'), (@question_id, 'Quite empathetic'), (@question_id, 'Somewhat empathetic'), (@question_id, 'Barely empathetic'), (@question_id, 'Not empathetic at all');

-- 10. Insert the question about helping others
INSERT INTO Question (survey_id, text) VALUES (@survey_id, 'How often do you think I go out of my way to help others?');
SET @question_id = LAST_INSERT_ID();
INSERT INTO Answer (question_id, text) VALUES (@question_id, 'Always'), (@question_id, 'Often'), (@question_id, 'Sometimes'), (@question_id, 'Rarely'), (@question_id, 'Never');

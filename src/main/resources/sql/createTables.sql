-- Create User Table
CREATE TABLE User (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create Category Table
CREATE TABLE Category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code CHAR(3) NOT NULL UNIQUE,  -- Short code
    description VARCHAR(255) NOT NULL
);

-- Create Survey Table
CREATE TABLE Survey (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category_id BIGINT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- Create Question Table
CREATE TABLE Question (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    survey_id BIGINT NOT NULL,
    text VARCHAR(255) NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES Survey(id)
);

-- Create Answer Table
CREATE TABLE Answer (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question_id BIGINT NOT NULL,
    text VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES Question(id)
);

-- Create Response Table
CREATE TABLE Response (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question_id BIGINT NOT NULL,
    answer_id BIGINT,
    text_response TEXT,
    user_id BIGINT,  -- User who gave the response
    FOREIGN KEY (question_id) REFERENCES Question(id),
    FOREIGN KEY (answer_id) REFERENCES Answer(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

ALTER TABLE Question
    ADD COLUMN correct_answer_id BIGINT,
    ADD CONSTRAINT fk_correct_answer FOREIGN KEY (correct_answer_id) REFERENCES Answer(id);

let currentSurveyIndex = 0;
let currentQuestionIndex = 0;
let surveys = [];
let responses = [];

document.addEventListener('DOMContentLoaded', function() {
    fetchSurveys();
});

function fetchSurveys() {
    fetch('http://localhost:8080/api/surveys/all')
        .then(response => response.json())
        .then(data => {
            surveys = data;
            displaySurvey(0); // Start with the first survey
        });
}

function displaySurvey(index) {
    let survey = surveys[index];
    document.getElementById('surveyTitle').textContent = survey.surveyTitle;
    document.getElementById('surveyDescription').textContent = survey.surveyDescription;
    document.getElementById('categoryDescription').textContent = survey.categoryDescription;
    displayQuestion(0); // Start with the first question
}

function displayQuestion(index) {
    let question = surveys[currentSurveyIndex].questions[index];
    let container = document.getElementById('questionContainer');
    container.innerHTML = `<p>${question.text}</p>`;

    let form = document.createElement('form');
    form.id = 'questionForm';

    question.options.forEach(option => {
        let label = document.createElement('label');
        label.htmlFor = 'option' + option.id;
        label.textContent = option.text;
        label.className = 'option-label';

        let radioInput = document.createElement('input');
        radioInput.type = 'radio';
        radioInput.name = 'questionOption';
        radioInput.value = option.id;
        radioInput.id = 'option' + option.id;

        label.insertBefore(radioInput, label.firstChild);
        form.appendChild(label);
        // Removed form.appendChild(document.createElement('br')); to reduce vertical spacing
    });

    container.appendChild(form);

    // Setup next button to call handleAnswer
    document.getElementById('nextBtn').onclick = handleAnswer;  // Ensure nextBtn exists and is intended for this purpose

    // Adjust button display logic
    document.getElementById('prevBtn').style.display = index > 0 ? 'inline-block' : 'none';
    document.getElementById('nextBtn').style.display = currentSurveyIndex === surveys.length - 1 && index === surveys[currentSurveyIndex].questions.length - 1 ? 'none' : 'inline-block'; // Show the Next button to allow answer handling
    document.getElementById('submitBtn').style.display = currentSurveyIndex === surveys.length - 1 && index === surveys[currentSurveyIndex].questions.length - 1 ? 'inline-block' : 'none';
}

function handleAnswer() {
    let selectedOption = document.querySelector('input[name="questionOption"]:checked');
    if (selectedOption) {
        responses.push({
            questionId: surveys[currentSurveyIndex].questions[currentQuestionIndex].id,
            answerId: parseInt(selectedOption.value)
        });

        if (currentSurveyIndex === surveys.length - 1 && currentQuestionIndex === surveys[currentSurveyIndex].questions.length - 1) {
            submitSurvey(); // Now handles last response correctly
        } else {
            nextQuestion();
        }
    } else {
        alert('Please select an option.');
    }
}

function nextQuestion() {
    let currentSurvey = surveys[currentSurveyIndex];
    // Increment the question index or move to the next survey
    if (currentQuestionIndex < currentSurvey.questions.length - 1) {
        // There are more questions in the current survey
        currentQuestionIndex++;
        displayQuestion(currentQuestionIndex);
    } else if (currentSurveyIndex < surveys.length - 1) {
        // There are no more questions in the current survey, but another survey exists
        currentSurveyIndex++;  // Move to the next survey
        currentQuestionIndex = 0; // Reset the question index for the new survey
        displaySurvey(currentSurveyIndex); // Start the new survey
    } else {
        // This is the last question of the last survey
        document.getElementById('submitBtn').style.display = 'inline-block'; // Show submit button
        document.getElementById('nextBtn').style.display = 'none'; // Optionally hide the next button
    }
}

function prevQuestion() {
    if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        displayQuestion(currentQuestionIndex);
    }
}

function submitSurvey() {
    // Ensure the last answer is recorded if coming directly from the last question
    let selectedOption = document.querySelector('input[name="questionOption"]:checked');
    if (selectedOption) {
        // This condition ensures we do not add duplicates
        if (responses.length !== surveys[currentSurveyIndex].questions.length) {
            responses.push({
                questionId: surveys[currentSurveyIndex].questions[currentQuestionIndex].id,
                answerId: parseInt(selectedOption.value)
            });
        }
    } else {
        alert('Please select an option.');
        return;
    }

    let userId = localStorage.getItem('userId');
    let responsesWithUser = responses.map(response => ({...response, userId: userId}));

    fetch('http://localhost:8080/api/surveys/submit', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(responsesWithUser)
    })
        .then(response => {
            if (response.ok) {
                window.location.href = '/api/review.html';
            } else {
                throw new Error('Failed to submit survey');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error submitting survey. Please try again.');
        });
}


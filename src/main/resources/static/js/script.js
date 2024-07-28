function startSurvey() {
    const userName = document.getElementById('username').value.trim();
    if (userName) {
        createUser(userName);
    } else {
        alert("Please enter your name to start the survey!");
    }
}

function createUser(userName) {
    fetch('http://localhost:8080/api/users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ name: userName })
    })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            localStorage.setItem('userId', data.id); // Assuming the response has an id field
            window.location.href = '/api/survey.html'; // Redirect to the survey page
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('Error adding user. Please try again.');
        });
}

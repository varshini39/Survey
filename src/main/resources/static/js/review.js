document.addEventListener('DOMContentLoaded', function() {
    fetchRankChart();
    fetchStats();
});

function fetchRankChart() {
    fetch('http://localhost:8080/api/analytics/knw/ratings')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('rankTable').getElementsByTagName('tbody')[0];
            Object.entries(data).forEach(([userName, score]) => {
                let row = tableBody.insertRow();
                let cell1 = row.insertCell(0);
                let cell2 = row.insertCell(1);
                cell1.innerHTML = userName;
                cell2.innerHTML = score;
            });
        })
        .catch(error => console.error('Error loading rank chart:', error));
}

function fetchStats() {
    fetch('http://localhost:8080/api/analytics/opn/statistics')
        .then(response => response.json())
        .then(data => {
            const statsContainer = document.getElementById('statsContainer');
            statsContainer.innerHTML = ''; // Clear previous content if any
            Object.entries(data).forEach(([question, answers]) => {
                let categoryDiv = document.createElement('div');
                categoryDiv.className = 'categoryDiv';

                let questionHeader = document.createElement('h3');
                questionHeader.textContent = question;
                categoryDiv.appendChild(questionHeader);

                Object.entries(answers).forEach(([answer, percentage]) => {
                    let p = document.createElement('p');
                    p.textContent = `${answer}: ${percentage.toFixed(2)}%`; // Format percentage to 2 decimal places
                    categoryDiv.appendChild(p);
                });

                statsContainer.appendChild(categoryDiv);
            });
        })
        .catch(error => console.error('Error loading OPN statistics:', error));
}



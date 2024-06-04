const userName = document.querySelector('.name');
const userSurname = document.querySelector('.surname');
const userAge = document.querySelector('.age');
const answer = document.querySelector('.output-box');

const submitButton = document.querySelector('.submit');
let string = '';

submitButton.addEventListener('click', function () {
    generateAnswer();
});

function generateAnswer() {
    if (userAge.value > 0 && userAge.value <= 12) {
        string = `Welcome, ${userName.value}! You are a childhood.`;
    }
    else if (userAge.value > 13 && userAge.value <= 19) {
        string = `Welcome, ${userName.value}! You are a teenage years.`;
    }
    else if (userAge.value > 20 && userAge.value <= 29) {
        string = `Welcome, ${userName.value}! You are a young adult.`;
    }
    else if (userAge.value > 30 && userAge.value <= 59) {
        string = `Welcome, ${userName.value}! You are a adult.`;
    }
    else if (userAge.value >= 60) {
        string = `Welcome, ${userName.value}! You are a senior.`;
    }
    else {
        string = 'Wrong input';
    }
    answer.textContent = string;
    if (answer.classList.toggle('hiden')) {
        submitButton.textContent = 'Submit';
    }
    else {
        submitButton.textContent = 'Again';
    }
    userName.value = '';
    userSurname.value = '';
    userAge.value = '';
}
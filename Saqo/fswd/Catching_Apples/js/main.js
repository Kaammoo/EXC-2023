// script.js

document.addEventListener('DOMContentLoaded', () => {
    const gameContainer = document.querySelector('.game-container');
    const basket = document.querySelector('.basket');
    const startButton = document.getElementById('startButton');
    const timerDisplay = document.getElementById('timer');
    let basketLeft = gameContainer.offsetWidth / 2 - basket.offsetWidth / 2;
    const basketSpeed = 30;
    let appleFallInterval;
    let gameTimer;
    let remainingTime = 30;
    let score = 0;

    // Function to start the game
    function startGame() {
        score = 0;
        remainingTime = 30;
        timerDisplay.textContent = remainingTime;
        startButton.style.display = 'none';
        document.addEventListener('keydown', moveBasket);
        appleFallInterval = setInterval(createApple, 2000);
        gameTimer = setInterval(updateTimer, 1000);
    }

    // Function to update the timer
    function updateTimer() {
        remainingTime--;
        timerDisplay.textContent = remainingTime;
        if (remainingTime <= 0) {
            endGame();
        }
    }

    // Function to end the game
    function endGame() {
        clearInterval(appleFallInterval);
        clearInterval(gameTimer);
        document.removeEventListener('keydown', moveBasket);
        alert(`Game Over! Your score: ${score}`);
        startButton.style.display = 'block';
    }

    // Function to move the basket
    function moveBasket(event) {
        if (event.key === 'ArrowLeft') {
            basketLeft = Math.max(basketLeft - basketSpeed, 0);
        } else if (event.key === 'ArrowRight') {
            basketLeft = Math.min(basketLeft + basketSpeed, gameContainer.offsetWidth - basket.offsetWidth);
        }``
        basket.style.left = `${basketLeft}px`;
    }

    // Function to create apples
    function createApple() {
        const apple = document.createElement('img');
        apple.src = 'images/apple.jpg'
        apple.classList.add('apple');
        apple.style.left = `${Math.random() * (gameContainer.offsetWidth - 25)}px`;
        apple.style.top = '0px';
        gameContainer.appendChild(apple);

        let appleFallInterval = setInterval(() => {
            let appleTop = parseInt(apple.style.top);
            if (appleTop < gameContainer.offsetHeight - basket.offsetHeight) {
                apple.style.top = `${appleTop + 5}px`;
            } else {
                clearInterval(appleFallInterval);
                checkCatch(apple);
                gameContainer.removeChild(apple);
            }
        }, 50);
    }

    // Function to check if the apple is caught
    function checkCatch(apple) {
        const appleRect = apple.getBoundingClientRect();
        const basketRect = basket.getBoundingClientRect();

        if (
            appleRect.bottom >= basketRect.top &&
            appleRect.right >= basketRect.left &&
            appleRect.left <= basketRect.right
        ) {
            score++;
        }
    }

    // Event listener for the start button
    startButton.addEventListener('click', startGame);
});

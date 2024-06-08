document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("apple-container");
  const timeValue = document.getElementById("time-value");
  const scoreValue = document.getElementById("score-value");
  const basket = document.getElementById("basket");
  const numberOfApples = 20; // Number of apples to create
  let time = 20;
  let createdApples = 0;
  let score = 0;
  let basketPosition = window.innerWidth / 2; // Initial basket position

  function changeTime() {
    timeValue.textContent = time;
  }

  // Function to generate a random number within a range
  function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  // Function to create and animate an apple
  function createApple() {
    const apple = document.createElement("img");
    apple.src = "./images/apple.png";
    apple.alt = "Apple";
    apple.className = "apple";

    // Set random horizontal position
    const viewportWidth = window.innerWidth;
    const randomLeft = getRandomInt(0, viewportWidth - 100); // 100 is the width of the apple
    apple.style.left = `${randomLeft}px`;

    container.appendChild(apple);

    // Animate the image to move down the page
    const viewportHeight = window.innerHeight;
    let currentTop = 0;
    const appleHeight = 100; // Height of the apple

    const fallInterval = setInterval(() => {
      currentTop += 5; // Adjust the speed of falling as needed
      apple.style.top = `${currentTop}px`;

      // Check for collision
      checkCollision(apple);

      // Stop the apple when it reaches the bottom
      if (currentTop >= viewportHeight - appleHeight) {
        clearInterval(fallInterval);
        apple.remove();
      }
    }, 20); // Adjust the interval time as needed

    ++createdApples;
    if (createdApples < numberOfApples) {
      setTimeout(createApple, 1500);
    }
  }

  function checkCollision(apple) {
    const appleRect = apple.getBoundingClientRect();
    const basketRect = basket.getBoundingClientRect();

    if (
      appleRect.bottom >= basketRect.top &&
      appleRect.top <= basketRect.bottom &&
      appleRect.left <= basketRect.right &&
      appleRect.right >= basketRect.left
    ) {
      // Apple is in the basket's area
      score++;
      scoreValue.textContent = score;
      apple.remove();

      if (score >= 5) {
        window.location.href = "./win.html";
      }
    }
  }

  createApple();

  // Function to handle keydown events for basket movement
  function moveBasket(event) {
    const step = 20; // Number of pixels to move the basket
    switch (event.code) {
      case "KeyA":
        basketPosition = Math.max(basketPosition - step, 100); // Move left but not out of the screen
        break;
      case "KeyD":
        basketPosition = Math.min(
          basketPosition + step,
          window.innerWidth - 100
        ); // Move right but not out of the screen
        break;
    }
    basket.style.left = `${basketPosition}px`;
  }

  document.addEventListener("keydown", moveBasket);

  const interval = setInterval(() => {
    if (time > 0) {
      --time;
      changeTime();
    } else {
      clearInterval(interval);
      window.location.href = "./lose.html";
    }
  }, 1000);
});

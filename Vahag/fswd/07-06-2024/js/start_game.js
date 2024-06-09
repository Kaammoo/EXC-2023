document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("apple-container");
  const timeValue = document.getElementById("time-value");
  const scoreValue = document.getElementById("score-value");
  const basket = document.getElementById("basket");
  const numberOfApples = 20;
  let time = 20;
  let createdApples = 0;
  let score = 0;
  let basketPosition = window.innerWidth / 2;

  function changeTime() {
    timeValue.textContent = time;
  }

  function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  function createApple() {
    const apple = document.createElement("img");
    apple.src = "../images/apple.png";
    apple.alt = "Apple";
    apple.className = "apple";
    const viewportWidth = window.innerWidth;
    const appleHeight = 100;
    const randomLeft = getRandomInt(0, viewportWidth - appleHeight);
    apple.style.left = `${randomLeft}px`;

    container.appendChild(apple);

    let currentTop = 0;
    const fallInterval = setInterval(() => {
      currentTop += 5;
      apple.style.top = `${currentTop}px`;

      checkCollision(apple);

      if (currentTop >= viewportHeight - appleHeight) {
        clearInterval(fallInterval);
        apple.remove();
      }
    }, 20);

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
      score++;
      scoreValue.textContent = score;
      apple.remove();

      if (score >= 10) {
        window.location.href = "../pages/win.html";
      }
    }
  }

  createApple();

  function moveBasket(event) {
    const step = 20;
    switch (event.code) {
      case "KeyA":
        basketPosition = Math.max(basketPosition - step, 100);
        break;
      case "KeyD":
        basketPosition = Math.min(
          basketPosition + step,
          window.innerWidth - 100
        );
        break;
    }

    basket.style.left = `${basketPosition}px`;
  }

  document.addEventListener("keydown", moveBasket);

  const interval = setInterval(() => {
    if (time > 1) {
      --time;
      changeTime();
    } else {
      clearInterval(interval);
      window.location.href = "../pages/lose.html";
    }
  }, 1000);
});

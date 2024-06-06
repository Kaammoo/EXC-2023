const cells = document.querySelectorAll(".cell");
const restartButton = document.getElementById("restartButton");
let currentPlayer = "X";
let gameState = ["", "", "", "", "", "", "", "", ""];
const winningConditions = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];

cells.forEach((cell) => cell.addEventListener("click", handleCellClick));
restartButton.addEventListener("click", restartGame);

function handleCellClick(event) {
  const cell = event.target;
  const index = cell.getAttribute("data-index");

  if (gameState[index] !== "" || !gameActive) {
    return;
  }

  gameState[index] = currentPlayer;
  cell.textContent = currentPlayer;
  cell.style.pointerEvents = "none";

  if (checkWin()) {
    alert(`${currentPlayer} wins!`);
    gameActive = false;
    return;
  }

  if (gameState.every((cell) => cell !== "")) {
    alert(`It's a draw!`);
    return;
  }

  currentPlayer = currentPlayer === "X" ? "O" : "X";
}

function checkWin() {
  return winningConditions.some((condition) => {
    return condition.every((index) => {
      return gameState[index] === currentPlayer;
    });
  });
}

function restartGame() {
  gameState = ["", "", "", "", "", "", "", "", ""];
  cells.forEach((cell) => {
    cell.textContent = "";
    cell.style.pointerEvents = "auto";
  });
  currentPlayer = "X";
  gameActive = true;
}

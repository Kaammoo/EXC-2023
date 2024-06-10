var board = document.getElementById("board");
var cell = document.getElementsByClassName("cell");

var currentPlayer = "X";

const winCombinations = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7],
];

for (var i = 0; i < cell.length; ++i) {
  cell[i].addEventListener("click", cellClick);
}

function cellClick() {
  var data = [];

  if (!this.innerHTML) {
    this.innerHTML = currentPlayer;
  } else {
    return;
  }

  for (var i = 0; i < cell.length; i++) {
    if (cell[i].innerHTML == currentPlayer) {
      data.push(parseInt(cell[i].getAttribute("pos")));
    }
  }

  const winningCombination = checkWin(data);
  if (winningCombination) {
    drawWinLine(winningCombination);
    const winner = currentPlayer;
    setTimeout(() => {
      alert("The Winner is " + winner);
    }, 10);
    restart();
  } else if (
    [...document.querySelectorAll(".cell")].every((cell) => cell.innerHTML)
  ) {
    setTimeout(() => {
      alert("Nobody won :(");
    }, 10);
    restart();
  }
  currentPlayer = currentPlayer == "X" ? "O" : "X";
}

function checkWin(data) {
  for (let combination of winCombinations) {
    if (combination.every((pos) => data.includes(pos))) {
      return combination;
    }
  }
  return null;
}

function restart() {
  setTimeout(() => {
    for (let i = 0; i < cell.length; ++i) {
      cell[i].innerHTML = "";
    }
    const lines = document.querySelectorAll(".win-line");
    lines.forEach((line) => line.remove());
    currentPlayer = "X";
  }, 10);
}

function drawWinLine(combination) {
  const startPos = combination[0];
  const endPos = combination[2];
  const startCell = document.querySelector(`.cell[pos="${startPos}"]`);
  const endCell = document.querySelector(`.cell[pos="${endPos}"]`);
  const startX = startCell.offsetLeft + startCell.offsetWidth / 2;
  const startY = startCell.offsetTop + startCell.offsetHeight / 2;
  const endX = endCell.offsetLeft + endCell.offsetWidth / 2;
  const endY = endCell.offsetTop + endCell.offsetHeight / 2;

  const line = document.createElement("div");
  line.className = "win-line";
  line.style.width = `${Math.sqrt(
    Math.pow(endX - startX, 2) + Math.pow(endY - startY, 2)
  )}px`;
  line.style.transform = `rotate(${
    (Math.atan2(endY - startY, endX - startX) * 180) / Math.PI
  }deg)`;
  line.style.left = `${startX}px`;
  line.style.top = `${startY}px`;

  document.body.appendChild(line);
}

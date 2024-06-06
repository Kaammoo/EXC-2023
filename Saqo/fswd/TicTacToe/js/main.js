let playerText = document.getElementById('playerText');
let restartBtn = document.getElementById('restartBtn');
let boxes = Array.from(document.getElementsByClassName('box'));
let history = document.getElementById('history');

let winnerIndicator = getComputedStyle(document.body).getPropertyValue('--winning');

const O_TEXT = 'O';
const X_TEXT = 'X';
let currentPlayer = X_TEXT;

let spaces = Array(9).fill(null);

const startGame = () => {
    boxes.forEach(box => box.addEventListener('click', boxClicked));
}

function boxClicked(e) {
    const id = e.target.id;

    if (!spaces[id]) {
        spaces[id] = currentPlayer;
        e.target.innerText = currentPlayer;

        if (palyerHasWan() !== false) {
            playerText.innerText = `Player \'${currentPlayer}\' has wan!`;
            let winningBlocks = palyerHasWan();

            winningBlocks.map(box => boxes[box].style.backgroundColor = winnerIndicator);
            boxes.forEach(box => box.removeEventListener('click', boxClicked));

            createHistoryBox(`${currentPlayer}`);
            return;
        }

        currentPlayer = currentPlayer == X_TEXT ? O_TEXT : X_TEXT;
    }
}

const winningCombos = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
]

function palyerHasWan() {
    for (const condition of winningCombos) {
        let [a, b, c] = condition;

        if (spaces[a] && (spaces[a] == spaces[b] && spaces[a] == spaces[c])) {
            return [a, b, c];
        }
    }
    return false;
}

restartBtn.addEventListener('click', restart);

function restart() {
    spaces.fill(null);

    boxes.forEach(box => {
        box.innerText = '';
        box.style.backgroundColor = '';
        box.addEventListener('click', boxClicked);
    })

    playerText.innerText = 'Tic Tac Toe';

    currentPlayer = X_TEXT;
}

function getCurrentTime() {
    const now = new Date();
    let hours = now.getHours();
    let minutes = now.getMinutes();
    let seconds = now.getSeconds();

    // Add leading zero if needed
    hours = hours < 10 ? '0' + hours : hours;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    return `${hours}:${minutes}:${seconds}`;
}

function createHistoryBox(player) {
    let currentTime = getCurrentTime();
    const historyBox = document.createElement('div');
    historyBox.classList.add('history-box')
    // historyBox.innerText = `Player ${player} has wan!\tTime: ${currentTime}`;
    historyBox.style.whiteSpace = 'pre';
    historyBox.innerText = `Player ${player} has won!\t\t\t\tTime: ${currentTime}`;

    history.appendChild(historyBox);
}

startGame();
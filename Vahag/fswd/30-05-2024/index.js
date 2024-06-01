const display = document.getElementById("display");
let justCalculated = true;

function appendToDisplay(input) {
  if (justCalculated) {
    display.value = "";
    justCalculated = false;
  }
  display.value += input;
}

function clearDisplay() {
  display.value = "0";
  justCalculated = true;
}

function calculate() {
  try {
    display.value = eval(display.value);
    justCalculated = true;
  } catch (error) {
    display.value = "Error";
    justCalculated = true;
  }
}

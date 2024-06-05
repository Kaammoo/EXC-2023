// Task 1
const numbers = [2, 8, 1, -8, 5];

function sumOfEvenNumbers(numbers) {
  return numbers.reduce((total, current) => {
    return current % 2 === 0 ? total + current : total;
  });
}

// console.log(sumOfEvenNumbers(numbers));

// Task 2
const str = "Hello World!";

function reverseString(str) {
  return str.split("").reverse().join("");
}

// console.log(reverseString(str));

// Task 3
const strArr = ["SaQqqO", "vAhAAAg", "KaaaaaMMMMoooo"];

function capitalizeArr(arr) {
  return arr.map((current) => current.toUpperCase());
}

// console.log(capitalizeArr(strArr));

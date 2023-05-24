let x = 10;
let y = 4;
let result = 0;
let result2 = 0;

// postfix
result = x + y--;
console.log(result); // 14
console.log(y); // 3

// prefix
result2 = x + --y;
console.log(result2); // 12
console.log(y); // 2
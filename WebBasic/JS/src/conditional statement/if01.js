const currentYear = 2023;
let birthYear;
let age;

birthYear = parseInt(prompt("Enter your birth year"));
age = currentYear - birthYear + 1;
console.log(`Your age is ${age}`);

if (age < 20) {
    alert("성인 X");
}

alert(`${currentYear} 년 현재, ${age}세 입니다.`);
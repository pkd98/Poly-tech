function addNum(...numbers) {
    let sum = 0;
    for (let number of numbers) {
        sum += number;
    }
    return sum;
};

console.log(addNum(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));

// arguments를 응용하여 동일한 출력 결과 나오는 함수

function addNum2() {
    let sum = 0;
    for (let num of arguments) {
        sum += num;
    }
    return sum;

}

console.log(addNum2(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));

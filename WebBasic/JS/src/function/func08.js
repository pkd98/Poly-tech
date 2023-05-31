// 함수를 매개변수로 전달
function print(i) {
    console.log(i);
}

function callThreeTimes(aaa) {
    for (let i = 0; i < 3; i++) {
        aaa(i);
    }
}

callThreeTimes(print);
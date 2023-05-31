function displayA() {
    console.log("A");
}

function displayB() {
    // 2초 뒤에 실행
    setTimeout(() => console.log("B"), 2000);
}

function displayC() {
    console.log("C");
}

displayA();
displayB();
displayC();
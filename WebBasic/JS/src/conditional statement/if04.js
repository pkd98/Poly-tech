function isodd() {
    let input = prompt("숫자 입력");
    console.log(input);
    if (input) {
        input = parseInt(input);
        (input % 2) ? alert(`${input} : 홀수`) : alert(`${input} : 짝수`);
    }
}
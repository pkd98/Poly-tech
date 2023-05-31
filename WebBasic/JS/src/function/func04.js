// 함수 객체 인스턴스를 생성해주는 것이 원칙이나,
var add = new Function('a', 'b', 'return a + b');
console.log(add(1, 2));


// function 키워드 사용 정의
function plus(a, b) {
    return a + b;
}
console.log(plus(1, 2));
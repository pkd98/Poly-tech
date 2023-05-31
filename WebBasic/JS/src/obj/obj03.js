const pet = {
    name: '구름',
    // 객체 속성에 익명 함수 할당 (JS의 객체 메서드 선언)
    eat: function (food) {
        console.log(this.name + '(이)가 ' + food + '를 먹는다');
    }
}

pet.eat("닭고기");
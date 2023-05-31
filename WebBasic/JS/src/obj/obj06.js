const test = {
    // 선언적 익명함수
    foo: function () {
        console.log(this);
    },
    // 화살표 함수
    bar: () => {
        test: 1;
        console.log(this);
    }
};

test.foo();
test.bar();
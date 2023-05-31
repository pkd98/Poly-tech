const student = {};

const poly = [
    ['park', 'great developer', 100],
    ['kim', 'great leader', 80],
    ['lee', 'great operator',]
];

// poly에 있는 2차원 배열을 객체로 변환하는 코드
// 컬럼명 정의
let keys = ["name", "dream", "score", "gender"];

for (let item of poly) {
    let col = {};

    for (let i = 0; i < keys.length; i++) {
        if (item[i] == undefined || item[i] == null || item[i] == "" || item[i] == NaN) {
            item[i] = "";
        }
        col[keys[i]] = item[i];
    }
    let key = item[0];
    student[key] = col;
}

console.log(student);
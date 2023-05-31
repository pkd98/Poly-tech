// 동적 속성 수정
const student = { // 빈 객체

};
// 속성 추가
student.name = "John";
student.hobby = "Playing";
student.goal = "To become a full stack developer";
console.log(student);

//속성 삭제
delete student.hobby;
console.log(student);
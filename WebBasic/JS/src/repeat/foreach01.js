let student = ["a", "b", "c", "d"];

student.forEach(function (el) {
    console.log(el);
});

student.forEach(el => {
    el = "test";
    console.log(el);
});

console.log(student);
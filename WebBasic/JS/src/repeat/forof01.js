let student = ["a", "b", "c", "d"];

for (item of student) {
    console.log(item);
}

for (item of student) {
    item = "화이팅";
    console.log(item);
}

console.log(student);
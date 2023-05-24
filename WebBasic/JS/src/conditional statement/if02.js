function birthCheck() {
    const date = new Date();
    const currentYear = date.getFullYear();
    let birthYear;
    let age;

    birthYear = prompt("Enter your birth year")

    if (birthYear != "" && birthYear != null && birthYear.length == 4) {
        birthYear = parseInt(birthYear);
        if (!isNaN(birthYear)) {
            age = currentYear - birthYear + 1;
            // console.log(`Your age is ${age}`);
            if (age < 20) {
                alert("성인 X");
            }
            alert(`${currentYear} 년 현재, ${age}세 입니다.`);
        }
    } else {
        alert("Please enter your birth year");
        console.log(birthCheck);
    }
}
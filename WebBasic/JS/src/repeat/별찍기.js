let index = 0;

for (let i = 1; i <= 5; i++) {
    let answer = "";

    for (let j = 1; j <= 5; j++) {
        if (j <= i) {
            answer += "*";
        }
        else {
            answer += " ";
        }
    }

    if (i == 5) {
        answer += "?";
    } else {
        answer += " ";
    }

    for (let j = 5; j >= 1; j--) {
        if (j <= i) {
            answer += "*";
        }
        else {
            answer += " ";
        }
    }
    console.log(answer);
}

for (let i = 1; i <= 5; i++) {
    let answer = "";

    for (let j = 1; j <= 5; j++) {
        if (j >= i) {
            answer += "*";
        }
        else {
            answer += " ";
        }
    }
    answer += "?";

    for (let j = 5; j >= 1; j--) {
        if (j >= i) {
            answer += "*";
        }

        else {
            answer += " ";
        }
    }
    console.log(answer);
}
console.log("     ?");
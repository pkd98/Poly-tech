let i = 5;
let status = false;

do {
    console.log(i);
    i--;
} while (i > 0);

i = 5;
while (i > 0) {
    console.log(i);
    i--;
}

do {
    console.log(i);
    i--;
} while (status);
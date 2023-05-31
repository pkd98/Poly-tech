for (let i = 0; i < 5; i++) {
    console.log(i);
}
for (let i = 0, j = 1; i < 5; i++) {
    console.log("i = " + i + ", j = " + j);
}

for (let i = 0, j = 1; i < 5; i++, j += 5) {
    console.log("i = " + i + ", j = " + j);
}


let str = "경기도 광명시";

for (let i = 0; i < str.length; i++) {
    console.log(str[i]);
}

const arr = [10, "banana", true]; // 타입이 없기 때문에 여러 형 대입 가능
arr.push("데이터");
arr[10] = "test";
for (let i = 0; i < arr.length; i++) {
    console.log(arr[i]);
}
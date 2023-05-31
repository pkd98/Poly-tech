const product = ['milk', 'bread', 'eggs', 'cheese', 'butter'];
console.log(product);

// 얕은 복사
const goods = product;
goods.push("tea");
console.log(product);

goods.pop();

// 깊은 복사
const food = [...product];
food.push("rice");
console.log(product);
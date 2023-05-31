// 객체 선언
const obj = {
    product: 'computer',
    type: 'laptop',
    brand: 'lenovo',
    price: '2200',
    launch: '2019'
};

for (let key in obj) {
    console.log(key, obj[key]);

}
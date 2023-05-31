// 객체 선언
const obj = {
    product: 'computer',
    type: 'laptop',
    brand: 'lenovo',
    price: '2200',
    launch: '2019'
};
// 객체 확인
console.log(obj);
// 속성 접근 1
console.log(obj.product);
// 속성 접근 2 : 동적 프로그래밍시 유용
console.log(obj['product']);
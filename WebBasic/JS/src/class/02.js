// class 선언
class Book {
    // 생성자 선언
    constructor(title, price) {
        this.title = title;
        this.price = price;
    }
    // 메서드 정의
    buy() {
        console.log(`${this.title}을(를) ${this.price} 가격으로 구매`);
    }
}

let book1 = new Book("JavaScript", 3000);
console.log(book1);
book1.buy();

class textBook extends Book {
    constructor(title, price, major) {
        super(title, price);
        this.major = major;
    }
    buy() {
        console.log(`${this.major} 전공, ${this.title}을(를) ${this.price} 가격으로 구매`);
    }
}

let book2 = new textBook("algorithm", 3000, "컴퓨터공학");
console.log(book2);
book2.buy();
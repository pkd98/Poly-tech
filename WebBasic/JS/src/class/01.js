class Book {
    constructor(title, pages, done) {
        this.title = title;
        this.pages = pages;
        this.done = done;
    }

    finish() {
        let str = "";
        this.done === false ? str = '읽는중' : str = '다읽음';
        return str;
    }
}

let git = new Book("Git Book", 500, false);
console.log(git);
console.log(git.finish());
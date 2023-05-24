let obj = {
    hello: function () {
        console.log("hello");
    },
    park: function () {
        console.log("park");
    }
}

let name = "hello";
obj[name]();
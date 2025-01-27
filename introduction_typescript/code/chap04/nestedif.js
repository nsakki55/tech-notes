"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var num = Math.round(Math.random() * 100);
console.log("num\u306E\u5024: ".concat(num));
if (num % 2 == 0) {
    console.log("2の倍数");
    if (num % 3 == 0) {
        console.log("3の倍数");
    }
}
else {
    console.log("2の倍数ではない");
}
console.log("処理終了");

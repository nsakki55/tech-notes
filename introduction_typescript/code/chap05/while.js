"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
console.log("start");
var num = Math.round(Math.random() * 10);
while (num != 9) {
    console.log("random num: ".concat(num));
    num = Math.round(Math.random() * 10);
}
console.log("exit");

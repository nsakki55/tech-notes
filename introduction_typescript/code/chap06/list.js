"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var list = [2, 4, 5, 2, 1];
for (var _i = 0, list_1 = list; _i < list_1.length; _i++) {
    var element = list_1[_i];
    console.log(element);
}
console.log("list: ".concat(list));
console.log("list: ".concat(list[8]));
list[10] = 10;
console.log("list: ".concat(list));

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function showCircumference(radius, pi) {
    if (pi === void 0) { pi = 3.14; }
    var circumference = 2 * pi * radius;
    console.log("result: ".concat(circumference));
}
showCircumference(3, 3.142);
showCircumference(8);

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PI = void 0;
exports.calcAreaOfCircle = calcAreaOfCircle;
exports.PI = 3.14;
function calcAreaOfCircle(radius, pi) {
    return pi * radius * radius;
}
function calcCircumference(radius, pi) {
    return 2 * pi * radius;
}

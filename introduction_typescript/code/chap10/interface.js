"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function showTotalWage(emp) {
    var total = emp.wage * emp.hours;
    console.log("".concat(emp.name, " get ").concat(total));
}
var keisuke = {
    name: "keisuke",
    wage: 1150,
    hours: 150
};
showTotalWage(keisuke);
function useCalc2Param(calc2Param) {
    var ans = calc2Param.calc(5, 4);
    console.log("result: ".concat(ans));
}
var multiplication = {
    name: "multiple",
    calc: function (num1, num2) {
        return num1 * num2;
    }
};
useCalc2Param(multiplication);

"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Student = /** @class */ (function () {
    function Student(name, english, math, japanease) {
        this._name = "";
        this._english = 0;
        this._math = 0;
        this._japanese = 0;
        this._name = name;
        this._english = english;
        this._math = math;
        this._japanese = japanease;
    }
    // constructor(public name: string, public english: number, public math: number, public japanese: number) { }
    Student.prototype.showScoresSum = function () {
        var sum = this._english + this._math + this._japanese;
        console.log("".concat(this._name, " sum: ").concat(sum));
    };
    Object.defineProperty(Student.prototype, "total", {
        get: function () {
            return this._english + this._math + this._japanese;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Student.prototype, "english", {
        set: function (value) {
            if (value < 0) {
                value = 0;
            }
            this._english = value;
        },
        enumerable: false,
        configurable: true
    });
    return Student;
}());
var taro = new Student("宮本太郎", 78, 82, 85);
taro.showScoresSum();
console.log("sum: ".concat(taro.total));
taro.english = -20;
console.log(taro);
var Radius = /** @class */ (function () {
    function Radius() {
    }
    Radius.showCircumference = function (radius) {
        var circumference = 2 * 3.14 * radius;
        console.log("\u534A\u5F84".concat(radius, "\u306E\u5186\u5468\u306E\u9577\u3055: ").concat(circumference));
    };
    return Radius;
}());
Radius.showCircumference(5);

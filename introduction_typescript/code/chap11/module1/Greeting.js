"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Greetings = void 0;
var Greetings = /** @class */ (function () {
    function Greetings(name) {
        this.name = "";
        this.name = name;
    }
    Greetings.prototype.sayHello = function () {
        console.log("".concat(this.name, " hello"));
    };
    return Greetings;
}());
exports.Greetings = Greetings;

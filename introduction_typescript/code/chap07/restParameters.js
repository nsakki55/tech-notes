"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function concatName(lastName, middleName, firstName) {
    return "".concat(lastName, "\u30FB").concat(middleName, "\u30FB").concat(firstName);
}
function sumScores() {
    var scores = [];
    for (var _i = 0; _i < arguments.length; _i++) {
        scores[_i] = arguments[_i];
    }
    var total = 0;
    for (var _a = 0, scores_1 = scores; _a < scores_1.length; _a++) {
        var score = scores_1[_a];
        total += score;
    }
    return total;
}
var name1 = concatName("tanaka", "daniel", "kenzo");
console.log(name1);
var nameArray = ["tanaka", "daniel", "kenzo"];
var name2 = concatName.apply(void 0, nameArray);
console.log(name2);

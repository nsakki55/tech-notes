"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var personalData = {
    name: "tomoko",
    age: 13,
    height: 32.4,
    weight: 43.5
};
console.log("".concat(personalData.name));
for (var key in personalData) {
    console.log("".concat(key, ": ").concat(personalData[key]));
}
personalData.weight = 22;
console.log(personalData);

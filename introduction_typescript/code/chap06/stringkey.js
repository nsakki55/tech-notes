"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var heightList = {
    "key1": 1111.3,
    "key2": 222.3,
    "key3": 333.3,
    "key4": 444.3,
};
for (var key in heightList) {
    console.log("".concat(key, ": ").concat(heightList[key]));
}
heightList['key1'] = 12;
heightList['key2'] = 23;
for (var key in heightList) {
    console.log("".concat(key, ": ").concat(heightList[key]));
}
console.log(heightList.key1);

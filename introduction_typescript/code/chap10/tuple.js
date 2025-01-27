"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var personalData = ['taro', 155, 54];
for (var _i = 0, personalData_1 = personalData; _i < personalData_1.length; _i++) {
    var element = personalData_1[_i];
    console.log(element);
}
personalData[0] = 'hoge';
var Rgb;
(function (Rgb) {
    Rgb[Rgb["RED"] = 0] = "RED";
    Rgb[Rgb["GREEN"] = 1] = "GREEN";
    Rgb[Rgb["BLUE"] = 2] = "BLUE";
})(Rgb || (Rgb = {}));
function showColorSelection(name, color) {
    var colorStr = "red";
    if (color == Rgb.GREEN) {
        colorStr = "green";
    }
    else if (color == Rgb.BLUE) {
        colorStr = "blue";
    }
    console.log("".concat(name, "'s color is ").concat(colorStr, "}"));
}
showColorSelection("hoge", Rgb.GREEN);

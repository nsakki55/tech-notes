"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Greeting_1 = require("./Greeting");
var Circles_1 = require("./Circles");
var taro = new Greeting_1.Greetings("egashira");
taro.sayHello();
var radius = 5;
var ans = (0, Circles_1.calcAreaOfCircle)(radius, Circles_1.PI);
console.log("result: ".concat(ans));

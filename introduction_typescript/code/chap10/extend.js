"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
var Greetings = /** @class */ (function () {
    function Greetings(name) {
        this._name = "";
        this._name = name;
    }
    Greetings.prototype.sayHello = function () {
        console.log("".concat(this._name, ", hello"));
    };
    return Greetings;
}());
var GoodMorning = /** @class */ (function (_super) {
    __extends(GoodMorning, _super);
    function GoodMorning() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    GoodMorning.prototype.sayGoodMorning = function () {
        console.log("".concat(this._name, ", good morning"));
    };
    return GoodMorning;
}(Greetings));
var taro = new GoodMorning("egashira");
taro.sayGoodMorning();
taro.sayHello();
var HelloWithNice = /** @class */ (function (_super) {
    __extends(HelloWithNice, _super);
    function HelloWithNice() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    HelloWithNice.prototype.sayHello = function () {
        _super.prototype.sayHello.call(this);
        console.log("nice to meet you");
    };
    return HelloWithNice;
}(Greetings));
var saburo = new HelloWithNice("saburo");
saburo.sayHello();
var HelloWithMsg = /** @class */ (function (_super) {
    __extends(HelloWithMsg, _super);
    function HelloWithMsg(name, msg) {
        var _this = _super.call(this, name) || this;
        _this.msg = "";
        _this.msg = msg;
        return _this;
    }
    HelloWithMsg.prototype.sayHello = function () {
        _super.prototype.sayHello.call(this);
        console.log(this.msg);
    };
    return HelloWithMsg;
}(Greetings));
var shiro = new HelloWithMsg("shiro", "nice weather");
shiro.sayHello();

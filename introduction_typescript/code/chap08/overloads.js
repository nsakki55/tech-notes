"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function descOneself(name, msgOrMonth, day) {
    var desc = "hello ".concat(name);
    if (typeof msgOrMonth == "string") {
        desc += msgOrMonth;
    }
    else {
        desc += "".concat(msgOrMonth, "month ").concat(day, " day");
    }
    console.log(desc);
}
descOneself("egashira", "hello");
descOneself("egashira", 6, 1);

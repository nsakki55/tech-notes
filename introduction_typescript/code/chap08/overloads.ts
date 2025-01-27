export {}

function descOneself(name: string, message: string);
function descOneself(name: string, month: number, day: number);
function descOneself(name: string, msgOrMonth: number|string, day?: number) {
    let desc = `hello ${name}`;
    if(typeof msgOrMonth == "string") {
        desc += msgOrMonth;
    } else {
        desc += `${msgOrMonth}month ${day} day`;
    }
    console.log(desc);
}

descOneself("egashira", "hello");
descOneself("egashira", 6, 1);

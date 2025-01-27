export {}

interface Emp {
    name: string;
    wage: number;
    hours: number;
}

function showTotalWage(emp: Emp) {
    const total = emp.wage * emp.hours;
    console.log(`${emp.name} get ${total}`);
}

const keisuke: Emp = {
    name: "keisuke",
    wage: 1150,
    hours: 150
}

showTotalWage(keisuke);

interface Calc2Param { 
    name: string;
    calc(num1: number, num2: number): number;
}

function useCalc2Param(calc2Param: Calc2Param) {
    const ans = calc2Param.calc(5, 4);
    console.log(`result: ${ans}`);
}

const multiplication: Calc2Param = {
    name: "multiple",
    calc(num1: number, num2: number): number {
        return num1 * num2
    }
}

useCalc2Param(multiplication);

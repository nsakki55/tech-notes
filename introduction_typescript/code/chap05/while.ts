export {}

console.log("start");
let num = Math.round(Math.random() * 10);
while (num != 9) {
    console.log(`random num: ${num}`);
    num = Math.round(Math.random() * 10);
}
console.log("exit");

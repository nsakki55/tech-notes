export {}

const list: number[] = [2, 4, 5,2,1];

for (const element of list) {
    console.log(element);
}
console.log(`list: ${list}`);
console.log(`list: ${list[8]}`);
list[10] = 10;
console.log(`list: ${list}`);

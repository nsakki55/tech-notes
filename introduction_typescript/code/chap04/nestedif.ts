export {}

const num = Math.round(Math.random() * 100);
console.log(`numの値: ${num}`);

if (num % 2 == 0) {
    console.log("2の倍数");
    if (num % 3 == 0) {
        console.log("3の倍数");
    }
} else {
    console.log("2の倍数ではない");
}
console.log("処理終了");

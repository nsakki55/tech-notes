export {}

function showCircumference(radius: number, pi: number = 3.14): void {
    const circumference = 2 * pi * radius;
    console.log(`result: ${circumference}`)
}

showCircumference(3, 3.142)
showCircumference(8)

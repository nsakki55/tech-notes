export const PI = 3.14;

export function calcAreaOfCircle(radius: number, pi: number): number {
    return pi * radius * radius;
}

function calcCircumference(radius: number, pi: number): number {
    return 2 * pi * radius;
}

export {}

const personalData: [string, number, number] = ['taro', 155, 54];
for (const element of personalData) {
    console.log(element);
}

personalData[0] = 'hoge';


enum Rgb {RED, GREEN, BLUE} 

function showColorSelection(name: string, color: Rgb) {
    let colorStr = "red";
    if (color == Rgb.GREEN) {
        colorStr = "green";
    } else if (color == Rgb.BLUE) {
        colorStr = "blue";
    }
    console.log(`${name}'s color is ${colorStr}`);
}
showColorSelection("hoge", Rgb.GREEN);

export {}

class Student {
    private _name: string = "";
    private _english: number = 0;
    private _math: number= 0;
    private _japanese: number = 0;

    constructor(name: string, english: number, math: number, japanease: number) {
        this._name = name
        this._english = english
        this._math = math
        this._japanese = japanease
    }

	// constructor(public name: string, public english: number, public math: number, public japanese: number) { }

    showScoresSum() {
        const sum = this._english + this._math + this._japanese;
        console.log(`${this._name} sum: ${sum}`);
    }

    get total(): number {
        return this._english + this._math + this._japanese;
    }

    set english(value: number) {
        if(value < 0) {
            value = 0;
        }
        this._english = value;
    }

}

const taro = new Student("宮本太郎", 78, 82, 85);
taro.showScoresSum();

console.log(`sum: ${taro.total}`);

taro.english = -20;
console.log(taro);


class Radius {
    static showCircumference(radius: number) {
        const circumference = 2 * 3.14 * radius;
		console.log(`半径${radius}の円周の長さ: ${circumference}`);
    }
}
Radius.showCircumference(5);

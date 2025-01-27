export class Greetings {
    protected name: string = "";

    constructor(name: string) { 
        this.name = name;
    }

    sayHello() {
        console.log(`${this.name} hello`);
    }
}
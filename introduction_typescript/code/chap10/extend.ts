export {}

class Greetings {
    protected _name: string = "";

    constructor(name: string) { 
        this._name = name;
    }

    sayHello() {
        console.log(`${this._name}, hello`);
    }
}

class GoodMorning extends Greetings {
    sayGoodMorning() {
        console.log(`${this._name}, good morning`)
    }
}

const taro = new GoodMorning("egashira");
taro.sayGoodMorning();
taro.sayHello();


class HelloWithNice extends Greetings {
    sayHello(): void {
       super.sayHello();
       console.log("nice to meet you") ;
    }
}

const saburo = new HelloWithNice("saburo");
saburo.sayHello();


class HelloWithMsg extends Greetings { 
    protected msg: string = "";

    constructor(name: string, msg: string) {
        super(name);
        this.msg = msg;
    }

    sayHello(): void {
        super.sayHello();
        console.log(this.msg);
    }
}

const shiro = new HelloWithMsg("shiro", "nice weather");
shiro.sayHello();
import { Greetings } from "./Greeting";
// import {PI, calcAreaOfCircle as calcCircle} from "./Circles";
import * as circle from "./Circles";

const taro = new Greetings("egashira");
taro.sayHello();


const radius = 5;
const ans = circle.calcAreaOfCircle(radius, circle.PI);
console.log(`result: ${ans}`);


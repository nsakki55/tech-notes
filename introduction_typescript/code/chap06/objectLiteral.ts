export {}

const personalData = {
    name: "tomoko",
    age: 13,
    height: 32.4,
    weight: 43.5
};


console.log(`${personalData.name}`)

for(const key in personalData) { 
    console.log(`${key}: ${personalData[key]}`);
}
personalData.weight = 22;
console.log(personalData);


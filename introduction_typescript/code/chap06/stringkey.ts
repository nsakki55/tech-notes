export {}

const heightList: {[key: string]: number} = 
{
    "key1": 1111.3,
    "key2": 222.3,
    "key3": 333.3,
    "key4": 444.3,
};

for(const key in heightList) {
    console.log(`${key}: ${heightList[key]}`);
}

heightList['key1'] = 12
heightList['key2'] = 23

for(const key in heightList) {
    console.log(`${key}: ${heightList[key]}`);
}

console.log(heightList.key1);

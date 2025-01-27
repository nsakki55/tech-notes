export {}

function concatName(lastName: string, middleName: string, firstName: string): string {
    return `${lastName}・${middleName}・${firstName}`;
}

function sumScores(...scores: number []): number {
    let total = 0;
    for(const score of scores) {
        total += score;
    }
    return total;
}

const name1 = concatName("tanaka", "daniel", "kenzo");
console.log(name1);

const nameArray = ["tanaka", "daniel", "kenzo"] as const;
const name2 = concatName(...nameArray);
console.log(name2);


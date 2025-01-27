export {}

function showRoundedElement(currentValue: number, index: number, array: number[]) {
    const roundedElement = Math.round(currentValue);
	console.log(`${index + 1}個目の要素${currentValue}の丸め処理後: ${roundedElement}`);
}

const numList = [45.112, 78.567, 66.891, 12.223, 28.341];
numList.forEach(showRoundedElement);


function showConcatName(f) {
    const result = f("田中", "太郎");
    console.log(result);
}

const func = function(lastName: string, firstName: string): string {
    return `${lastName} ${firstName}`;
}
showConcatName(func);

numList.forEach(
    (currentValue: number, index: number, array: number[]) => {
        const roundedElement = Math.round(currentValue);
        console.log(`${index + 1}個目の要素${currentValue}の丸め処理後: ${roundedElement}`);
    }
);


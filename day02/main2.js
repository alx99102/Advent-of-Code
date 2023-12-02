const fs = require('fs');
const input = fs.readFileSync('input.txt').toString().split('\n');


let sum = 0;
for(let i = 0; i < input.length; i++) {
    let row = input[i].substring(input[i].indexOf(':')+1);
    let parts = row.split(';');
    let max = [0,0,0];
    parts.forEach(element => {
        while(element.length > 0){

            element = element.trim();
            let num = Number.parseInt(element);
            element = element.substring(element.indexOf(' '));

            if(element.startsWith(" red")){
                if (num > max[0]) max[0] = num;
                element = element.substring(element.indexOf(' red')+ 6);
            } else if(element.startsWith(" green")) {
                if (num > max[1]) max[1] = num;
                element = element.substring(element.indexOf(' green')+ 8);
            }
            else if(element.startsWith(" blue")) {
                if (num > max[2]) max[2] = num;
                element = element.substring(element.indexOf(' blue')+ 7);
            }
            else {
                console.log(element);
            }
        }
    })

    sum += max[0]*max[1]*max[2];
}
console.log(sum);
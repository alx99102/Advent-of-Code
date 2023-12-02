var input = require('fs').readFileSync('input.txt').toString().split('\n');

let sum = 0;
const max = [12,13,14];

for(let i = 0; i < input.length; i++) {
    let rgb = [0,0,0];
    let str = input[i].substring(input[i].indexOf(':') + 2);
    
    let strs = str.split(';');

    let stop = false;
    strs.forEach(element => {
        rgb = [0,0,0];
        if(!stop)
            rgb = getInformation(element.trim(), rgb);
        if(!(rgb[0] <= max[0] && rgb[1] <= max[1] && rgb[2] <= max[2]))
            stop = true;
    });
    if(stop) continue;

    sum += i+1; // 1 based index on game numbers :/
}
console.log(sum);

function getInformation(str, rgb) {
    let num = Number.parseInt(str);
    str = str.substring(str.indexOf(' '));
    if(str.startsWith(" red")){
        rgb[0] += num;
        str = str.substring(str.indexOf(' red')+ 6);
    } else if(str.startsWith(" green")) {
        rgb[1] += num;
        str = str.substring(str.indexOf(' green')+ 8);
    }
    else if(str.startsWith(" blue")) {
        rgb[2] += num;
        str = str.substring(str.indexOf(' blue')+ 7);
    }

    if (str.length > 0) {
        return getInformation(str, rgb);
    } else {
        return rgb;
    }
}
var fs = require('fs');

enum Direction {
    L = 0,
    R = 1,
}
const target = "ZZZ";

const input: string = fs.readFileSync('input.txt', 'utf8');
let lines = input.split('\n');

const commands = lines[0].split("");

const table = {};

lines = lines.slice(2);

const starters: string[] = [];
for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const key = line.split(" ")[0];
    const valueStr = line.slice(line.indexOf("(")+1, line.length-1);
    const value = valueStr.split(", ");
    table[key] = value;

    // Part 2
    if(key.endsWith("A")) {
        starters.push(key);
    }
}

let i = 0;
let currentLine = "AAA";
while(true) {
    const command = Direction[commands[i % commands.length]];
    i++;
    currentLine = table[currentLine][command];
    if(currentLine === target) {
        console.log(`Found ${target} at ` + i);
        break;
    }
}

// Part 2
let currentLines = starters;
console.log(currentLines);
const sols: number[] = [];

for(let i=0; i < starters.length; i++) {
    let current = starters[i];
    let steps = 0;
    while(true) {
        const command = Direction[commands[steps % commands.length]];
        steps++;
        current = table[current][command];
        if(current.endsWith("Z")) {
            sols.push(steps);
            break;
        }
    }
}
    

let res = sols[0];
for(let i=1; i < sols.length; i++) {
    res = lcm(res, sols[i]);
}
console.log(res);

// Euclidean algorithm learned in COMP 232 :) Didn't think I'd ever use it
function gcd(a: number, b: number) {
    if (b === 0) return a;
    return gcd(b, a % b);
}

function lcm(a: number, b: number) {
    return (a * b) / gcd(a, b);
}
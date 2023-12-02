var fs = require('fs');
var data = fs.readFileSync('input.txt').split('\n');

var sum = 0;
var digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

data.forEach((line) => {
    var min = Infinity;
    var minNum = Infinity;
    var max = -Infinity;
    var maxNum = -Infinity;

    for (var j = 0; j < digits.length; j++) {
        var digitIndex = line.indexOf(digits[j]);
        var digitLastIndex = line.lastIndexOf(digits[j]);

        if (digitIndex != -1 && digitIndex < min) {
            min = digitIndex;
            minNum = j;
        }

        if (digitLastIndex > max) {
            max = digitLastIndex;
            maxNum = j;
        }

    }

    sum += minNum * 10 + maxNum;
});

console.log("Total Sum: ", sum);

<?php

$file = fopen("input.txt", "r");
$data = fread($file, filesize("input.txt"));
fclose($file);

$lines = explode("\n", $data);

///////////////////////////////////////////
//               PART 1                  //
///////////////////////////////////////////

// 2d array with 4 values of 2 numbers
$values = array(
    array(0, 0),
    array(0, 0),
    array(0, 0),
    array(0, 0)
);

// handle values
for ($i = 0; $i < 2; $i++) {

    $line = $lines[$i];
    $line = preg_replace("/\s+/", " ", $line); // replace multiple spaces with one space
    $line = explode(" ", $line);
    $line = array_slice($line, 1);

    for ($j = 0; $j < count($line); $j++) {
        $values[$j][$i] = $line[$j];
    }
}

$wins = array(0, 0, 0, 0);

for ($i = 0; $i<count($values); $i++) {
    for($holdTime = 0; $holdTime < $values[$i][0]; $holdTime++) {
        if (calculateDistance($holdTime, $values[$i][0]) > $values[$i][1]) {
            $wins[$i]++;
        }
    }
}

$a = array_reduce($wins, function($carry, $item) {
    return $carry * $item;
}, 1);
echo "Part 1: $a\n";

///////////////////////////////////////////
//               PART 2                  //
///////////////////////////////////////////

$wins = 0;

$time = substr(preg_replace(
            "/\s+/",
            "", 
            $lines[0]), strlen("Time:"));

$distance = substr(preg_replace(
            "/\s+/",
            "", 
            $lines[1]), strlen("Distance:"));

for ($holdTime = 0; $holdTime < $time; $holdTime++) {
    if (calculateDistance($holdTime, $time) > $distance) {
        $wins++;
    }
}

echo "Part 2: $wins\n";



function calculateDistance($holdTime, $totalTime) {
    $velocity = $holdTime;
    $travelTime = $totalTime - $holdTime;
    $distance = $velocity * $travelTime;

    return $distance;
}

?>


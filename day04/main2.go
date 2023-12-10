package main

import (
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	// read input.txt
	file, err := ioutil.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}

	content := strings.Split(string(file), "\n")

	// Get winning numbers and ticket numbers and store them in 2D array
	var nums [214][35]int // 214 rows, 10 values with 10 winning numbers and 25 ticket numbers

	for i := 0; i < len(content); i++ {
		content[i] = strings.ReplaceAll(content[i], "   ", " ")
		content[i] = strings.ReplaceAll(content[i], "  ", " ")
		contentSplitSpace := strings.Split(content[i], " ")

		for j := 0; j < 10; j++ {
			nums[i][j], err = strconv.Atoi(contentSplitSpace[j+2])
			if err != nil {
				panic(err)
			}
		}

		for j := 0; j < 25; j++ {
			nums[i][j+10], err = strconv.Atoi(contentSplitSpace[j+13])
			if err != nil {
				panic(err)
			}
		}
	}
	
	var totalCards int = 0
	for i := 0; i < 214; i++ {
		var queue []int
		queue = append(queue, i) // Start with the first card
		for len(queue) > 0 {
			current := queue[0]
			queue = queue[1:]
			totalCards++

			matches := 0
			for j := 10; j < 35; j++ {
				for k := 0; k < 10; k++ {
					if nums[current][j] == nums[current][k] {
						matches++
						break
					}
				}
			}

			for m := 1; m <= matches; m++ {
				if current+m < len(nums) {
					queue = append(queue, current+m)
				}
			}
		}
	}
	println(totalCards)
}
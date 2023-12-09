#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int findNum(char data[140][140], int x, int y) {
    // Move y to the start of the number
    while(y > 0 && data[x][y-1] >= '0' && data[x][y-1] <= '9') {
        y--;
    }

    int num = 0;

    while(y < 140 && data[x][y] >= '0' && data[x][y] <= '9') {
        num = num * 10 + (data[x][y] - '0');
        y++;
    }

    return num;
}

int gearRatio(char data[140][140], int x, int y) {
    int idx = 0;
    int nums[2] = {0};

    for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
            int newX = x + i;
            int newY = y + j;

            // Check bounds
            if (newX < 0 || newX >= 140 || newY < 0 || newY >= 140)
                continue;
            if (data[newX][newY] <= '9' && data[newX][newY] >= '0') {
                int temp = findNum(data, newX, newY);

                if ((idx == 0 || nums[0] != temp)&& idx < 2) {
                    nums[idx++] = temp;
                }
            }
        }
    }

    return nums[0] * nums[1];
}

int main() {
    FILE *fp;
    char data[140][140];

    fp = fopen("./input.txt", "r");
    if (fp == NULL) {
        perror("Error opening file");
        return 1;
    }

    for (int i = 0; i < 140; i++) {
        if (fread(data[i], 1, 140, fp) != 140) {
            break;
        }
        fgetc(fp); // skip \n char
    }
    fclose(fp);
  
    int sum = 0;
    // crawl through each char until we find a number.
    for(int i = 0; i < 140; i++) {
        for(int j = 0; j<140; j++) {
            if(data[i][j] == '*')
                sum += gearRatio(data, i, j);
        }
    }

    printf("%d\n", sum);
}
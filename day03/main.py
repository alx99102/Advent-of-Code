# read input.txt
with open("input.txt") as f:
    data = f.readlines()
data = [x.strip() for x in data]


rows = len(data)
cols = len(data[0])
sum_parts = 0

def is_symbol(cell):
    return cell in "*+#$%/@=&-?!"

# Function to check if a number is adjacent to a symbol
def adjacent_to_symbol(r, c):
    for dr in range(-1, 2):
        for dc in range(-1, 2):
            if dr == 0 and dc == 0:
                continue
            nr, nc = r + dr, c + dc
            if 0 <= nr < rows and 0 <= nc < cols and is_symbol(data[nr][nc]):
                return True
    return False
# Iterate over the data
row = 0
while row < rows:
    col = 0
    while col < cols:
        cell = data[row][col]
        # Check for a number
        if cell.isdigit():
            number = cell
            col += 1
            while col < cols and data[row][col].isdigit():
                number += data[row][col]
                col += 1
            # Check if the number is adjacent to a symbol
            if any(adjacent_to_symbol(row, c) for c in range(col - len(number), col)):
                sum_parts += int(number)
        else:
            col += 1
    row += 1

print(sum_parts)
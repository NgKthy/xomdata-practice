# Xom Data · Sort colors
# Problem: https://xomdata.com/practice/py-sort-colors
# Solved: 2026-10-05

def sort_colors(numbers):
    count = [0, 0, 0]
    for num in numbers:
        count[num] += 1
    return [0] * count[0] + [1] * count[1] + [2] * count[2]

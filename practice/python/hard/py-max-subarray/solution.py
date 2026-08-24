# Xom Data · Maximum subarray sum
# Problem: https://xomdata.com/practice/py-max-subarray
# Solved: 2026-08-24

def max_subarray(numbers):
    current = numbers[0]
    best = numbers[0]
    for num in numbers[1:]:
        current = max(num, current + num)
        best = max(best, current)
    return best

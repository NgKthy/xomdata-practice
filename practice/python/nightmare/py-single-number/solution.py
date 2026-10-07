# Xom Data · Single number
# Problem: https://xomdata.com/practice/py-single-number
# Solved: 2026-10-07

def single_number(numbers):
    result = 0
    for num in numbers:
        result ^= num
    return result

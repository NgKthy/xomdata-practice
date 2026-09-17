# Xom Data · Move zeroes
# Problem: https://xomdata.com/practice/py-move-zeros
# Solved: 2026-09-17

def move_zeros(numbers):
    non_zero = [x for x in numbers if x != 0]
    zeros_count = len(numbers) - len(non_zero)
    return non_zero + [0] * zeros_count

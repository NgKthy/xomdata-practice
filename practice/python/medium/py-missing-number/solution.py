# Xom Data · Missing number
# Problem: https://xomdata.com/practice/py-missing-number
# Solved: 2026-09-21

def missing_number(numbers):
    n = len(numbers) + 1
    expected_sum = n * (n + 1) // 2
    return expected_sum - sum(numbers)

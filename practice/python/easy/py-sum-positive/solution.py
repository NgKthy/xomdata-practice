# Xom Data · Total receipts
# Problem: https://xomdata.com/practice/py-sum-positive
# Solved: 2026-08-24

def sum_positive(numbers):
    return sum(x for x in numbers if x > 0)

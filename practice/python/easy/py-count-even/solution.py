# Xom Data · Count products with an even code
# Problem: https://xomdata.com/practice/py-count-even
# Solved: 2026-09-21

def count_even(numbers):
    return sum(1 for n in numbers if n % 2 == 0)

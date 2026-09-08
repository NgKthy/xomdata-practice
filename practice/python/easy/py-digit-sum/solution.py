# Xom Data · Sum of digits in the code
# Problem: https://xomdata.com/practice/py-digit-sum
# Solved: 2026-09-08

def digit_sum(number):
    return sum(int(d) for d in str(number))

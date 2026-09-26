# Xom Data · Fast exponentiation
# Problem: https://xomdata.com/practice/py-fast-power
# Solved: 2026-09-26

def power(x, n):
    result = 1
    base = x
    while n > 0:
        if n % 2 == 1:
            result *= base
        base *= base
        n //= 2
    return result

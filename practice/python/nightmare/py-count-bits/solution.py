# Xom Data · Counting bits
# Problem: https://xomdata.com/practice/py-count-bits
# Solved: 2026-09-28

def count_bits(n):
    result = [0] * (n + 1)
    for i in range(1, n + 1):
        result[i] = result[i >> 1] + (i & 1)
    return result

# Xom Data · Number of valid parentheses combinations
# Problem: https://xomdata.com/practice/py-catalan-parens
# Solved: 2026-10-07

def count_parens(n):
    # Số Catalan thứ n: C(2n, n) // (n + 1)
    from math import comb
    return comb(2 * n, n) // (n + 1)

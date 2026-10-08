# Xom Data · Customers who only bought at the first branch
# Problem: https://xomdata.com/practice/py-missing-customers
# Solved: 2026-10-08

def only_in_first(a, b):
    b_set = set(b)
    return sorted({x for x in a if x not in b_set})

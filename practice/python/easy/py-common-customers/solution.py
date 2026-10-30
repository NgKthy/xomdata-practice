# Xom Data · Customers who bought at both branches
# Problem: https://xomdata.com/practice/py-common-customers
# Solved: 2026-10-30

def common(a, b):
    return sorted(set(a) & set(b))

# Xom Data · Savings balance after several years
# Problem: https://xomdata.com/practice/py-compound-interest
# Solved: 2026-09-27

def balance_after(principal, rate, years):
    return round(principal * (1 + rate / 100) ** years, 2)

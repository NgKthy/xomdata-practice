# Xom Data · Restaurant tip suggestion
# Problem: https://xomdata.com/practice/py-tip-amount
# Solved: 2026-09-10

def tip_amount(bill, percent):
    return round(bill * percent / 100, 2)

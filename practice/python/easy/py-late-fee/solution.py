# Xom Data · Library late return fee
# Problem: https://xomdata.com/practice/py-late-fee
# Solved: 2026-08-28

def late_fee(days_late, fee_per_day):
    return max(0, days_late * fee_per_day)

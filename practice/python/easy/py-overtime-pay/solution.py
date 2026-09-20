# Xom Data · Weekly pay with overtime hours
# Problem: https://xomdata.com/practice/py-overtime-pay
# Solved: 2026-09-20

def overtime_pay(hours, rate):
    regular_hours = min(hours, 40)
    overtime_hours = max(0, hours - 40)

    pay = regular_hours * rate + overtime_hours * rate * 1.5
    return float(round(pay, 2))

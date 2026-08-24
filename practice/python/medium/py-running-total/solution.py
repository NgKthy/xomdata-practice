# Xom Data · Cumulative total by day
# Problem: https://xomdata.com/practice/py-running-total
# Solved: 2026-08-24

def running_total(numbers):
    result = []
    total = 0
    for num in numbers:
        total += num
        result.append(total)
    return result

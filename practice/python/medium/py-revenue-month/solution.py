# Xom Data · Total revenue by month
# Problem: https://xomdata.com/practice/py-revenue-month
# Solved: 2026-10-06

def revenue_by_month(records):
    result = {}
    for month, amount in records:
        if month not in result:
            result[month] = 0
        result[month] += amount
    return result

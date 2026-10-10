# Xom Data · Filter transactions inside a reporting period
# Problem: https://xomdata.com/practice/py-date-range-filter
# Solved: 2026-10-10

def within_dates(records, start, end):
    return [code for code, date in records if start <= date <= end]

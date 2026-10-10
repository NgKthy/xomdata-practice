# Xom Data · How many days a given month has
# Problem: https://xomdata.com/practice/py-days-in-month
# Solved: 2026-10-10

def days_in_month(year, month):
    if month == 2:
        if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
            return 29
        return 28
    if month in (4, 6, 9, 11):
        return 30
    return 31

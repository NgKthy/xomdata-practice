# Xom Data · Check leap year
# Problem: https://xomdata.com/practice/py-leap-year
# Solved: 2026-08-28

def is_leap_year(year):
    return year % 4 == 0 and (year % 100 != 0  or year % 400 == 0)

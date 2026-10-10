# Xom Data · Distance between two dates
# Problem: https://xomdata.com/practice/py-days-between
# Solved: 2026-10-10

from datetime import datetime

def days_between(a, b):
    d1 = datetime.strptime(a, "%Y-%m-%d")
    d2 = datetime.strptime(b, "%Y-%m-%d")
    return abs((d2 - d1).days)

# Xom Data · Weekday name from its number
# Problem: https://xomdata.com/practice/py-weekday-name
# Solved: 2026-09-09

def weekday_name(n):
    days = ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
    if 1 <= n <= 7:
        return days[n - 1]
    return None

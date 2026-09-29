# Xom Data · Next working day
# Problem: https://xomdata.com/practice/py-next-workday
# Solved: 2026-09-29

from datetime import datetime, timedelta

def next_workday(text):
    d = datetime.strptime(text, "%Y-%m-%d")
    d += timedelta(days=1)
    while d.weekday() >= 5:  
        d += timedelta(days=1)
    return d.strftime("%Y-%m-%d")

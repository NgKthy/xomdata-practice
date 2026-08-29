# Xom Data · Add up shift durations
# Problem: https://xomdata.com/practice/py-duration-sum
# Solved: 2026-08-29

def total_time(durations):
    total_minutes = 0
    for d in durations:
        h, m = map(int, d.split(':'))
        total_minutes += h * 60 + m
    hours = total_minutes // 60
    minutes = total_minutes % 60
    return f"{hours:02d}:{minutes:02d}"

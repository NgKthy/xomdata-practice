# Xom Data · Convert minutes to hours and minutes
# Problem: https://xomdata.com/practice/py-time-format
# Solved: 2026-09-10

def format_duration(minutes):
    hours = minutes // 60
    mins = minutes % 60
    return f"{hours}:{mins:02d}"

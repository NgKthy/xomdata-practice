# Xom Data · Completion rate of a delivery team
# Problem: https://xomdata.com/practice/py-completion-rate
# Solved: 2026-09-27

def completion_rate(done, total):
    if total == 0:
        return 0.0
    return round(done / total * 100, 2)

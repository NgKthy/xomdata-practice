# Xom Data · Longest run of days hitting the target
# Problem: https://xomdata.com/practice/py-longest-streak
# Solved: 2026-09-17

def longest_streak(sales, target):
    max_streak = 0
    current_streak = 0

    for s in sales:
        if s >= target:        
            current_streak += 1
            if current_streak > max_streak:
                max_streak = current_streak
        else:
            current_streak = 0

    return max_streak

# Xom Data · Second largest value
# Problem: https://xomdata.com/practice/py-second-largest
# Solved: 2026-08-24

def second_largest(numbers):
    unique = sorted(set(numbers), reverse = True)
    if len(unique) >= 2:
        return unique[1]
    return None

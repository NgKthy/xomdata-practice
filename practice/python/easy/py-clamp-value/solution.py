# Xom Data · Pull a sensor reading back into range
# Problem: https://xomdata.com/practice/py-clamp-value
# Solved: 2026-10-05

def clamp(value, low, high):
    if value < low:
        return low
    elif value > high:
        return high
    else:
        return value

# Xom Data · Record sales up to each day
# Problem: https://xomdata.com/practice/py-running-max
# Solved: 2026-08-30

def running_max(values):
    if not values:
        return []

    result = []
    current_max = values[0]
    for v in values:
        if v > current_max:
            current_max = v
        result.append(current_max)
    return result

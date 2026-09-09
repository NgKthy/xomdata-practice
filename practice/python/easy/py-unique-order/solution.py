# Xom Data · Remove duplicate names from the invite list
# Problem: https://xomdata.com/practice/py-unique-order
# Solved: 2026-09-09

def unique(items):
    seen = set()
    result = []
    for item in items:
        if item not in seen:
            seen.add(item)
            result.append(item)
    return result

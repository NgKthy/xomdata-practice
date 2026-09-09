# Xom Data · Spot a code entered twice
# Problem: https://xomdata.com/practice/py-has-duplicate
# Solved: 2026-09-09

def has_duplicate(items):
    seen = set()
    for item in items:
        if item in seen:
            return True
        seen.add(item)
    return False

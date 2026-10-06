# Xom Data · Rotate list to the right
# Problem: https://xomdata.com/practice/py-rotate-list
# Solved: 2026-10-06

def rotate(items, k):
    if not items:
        return []
    k %= len(items)
    return items[-k:] + items[:-k]

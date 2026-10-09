# Xom Data · Contact list ordered ignoring case
# Problem: https://xomdata.com/practice/py-case-insensitive-order
# Solved: 2026-10-09

def sort_names(names):
    return sorted(names, key=str.lower)

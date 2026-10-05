# Xom Data · Flatten grouped results by one level
# Problem: https://xomdata.com/practice/py-flatten-one-level
# Solved: 2026-10-05

def flatten(groups):
    return [item for group in groups for item in group]

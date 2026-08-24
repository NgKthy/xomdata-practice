# Xom Data · Group products by category
# Problem: https://xomdata.com/practice/py-group-category
# Solved: 2026-08-24

def group_by_category(items):
    groups = {}
    for name, category in items:
        if category not in groups:
            groups[category] = []
        groups[category].append(name)
    return groups

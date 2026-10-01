# Xom Data · Distinct values per group
# Problem: https://xomdata.com/practice/py-distinct-per-group
# Solved: 2026-10-01

def distinct_per_group(pairs):
    groups = {}
    for group, value in pairs:
        if group not in groups:
            groups[group] = set()
        groups[group].add(value)
    return {group: len(values) for group, values in groups.items()}

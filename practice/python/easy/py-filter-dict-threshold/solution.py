# Xom Data · Keep the branches that beat the target
# Problem: https://xomdata.com/practice/py-filter-dict-threshold
# Solved: 2026-10-06

def over_target(sales, target):
    return {branch: revenue for branch, revenue in sales.items() if revenue > target}

# Xom Data · Order regions by total sales
# Problem: https://xomdata.com/practice/py-group-then-sort
# Solved: 2026-10-07

def sorted_by_group_total(sales):
    totals = {}
    for region, amount in sales:
        totals[region] = totals.get(region, 0) + amount

    return sorted(totals.keys(), key=lambda r: (-totals[r], r))

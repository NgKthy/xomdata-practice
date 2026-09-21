# Xom Data · Count in-stock products
# Problem: https://xomdata.com/practice/py-in-stock
# Solved: 2026-09-21

def count_in_stock(quantities):
    return sum(1 for q in quantities if q > 0)

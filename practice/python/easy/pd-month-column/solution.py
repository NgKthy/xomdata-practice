# Xom Data · Add a month column from the order date
# Problem: https://xomdata.com/practice/pd-month-column
# Solved: 2026-09-14

import pandas as pd


def add_month(orders):
    result = orders.copy()
    result["month"] = result["order_date"].str.slice(0, 7)
    return result

# Xom Data · Orders within a date range
# Problem: https://xomdata.com/practice/pd-filter-date-range
# Solved: 2026-09-14

import pandas as pd


def orders_between(orders, start, end):
    # Keep the orders dated between start and end, both ends included.
    dates = pd.to_datetime(orders["order_date"])
    mask = (dates >= pd.to_datetime(start)) & (dates <= pd.to_datetime(end))
    return orders[mask]

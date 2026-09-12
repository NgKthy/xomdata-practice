# Xom Data · How many orders each staff member closed
# Problem: https://xomdata.com/practice/pd-group-count
# Solved: 2026-09-12

import pandas as pd


def orders_per_staff(orders):
    # Return how many rows each staff member has, sorted by name.
    return orders.groupby("staff").size().sort_index()

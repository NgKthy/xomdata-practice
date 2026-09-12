# Xom Data · The city that brought in the most
# Problem: https://xomdata.com/practice/pd-top-group
# Solved: 2026-09-12

import pandas as pd


def best_city(orders):
    # Return the name of the city with the highest total amount.
    totals = orders.groupby("city")["amount"].sum().sort_index()
    return totals.idxmax()

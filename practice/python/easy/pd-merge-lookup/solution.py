# Xom Data · Bring the customer name into the order table
# Problem: https://xomdata.com/practice/pd-merge-lookup
# Solved: 2026-09-12

import pandas as pd


def attach_customer_name(orders, customers):
    # Attach the customer name, keeping only orders found in the directory.
    name_map = customers.set_index("customer_id")["name"]
    result = orders[orders["customer_id"].isin(customers["customer_id"])].copy()
    result["name"] = result["customer_id"].map(name_map)
    return result.reset_index(drop = True)

# Xom Data · Turn status codes into words people read
# Problem: https://xomdata.com/practice/pd-map-labels
# Solved: 2026-09-12

import pandas as pd


def label_status(orders, labels):
    # Add a status_label column translated from the status codes.
    result = orders.copy()
    result["status_label"] = result["status"].map(labels)
    return result

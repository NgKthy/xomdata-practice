# Xom Data · Payments at or above a minimum
# Problem: https://xomdata.com/practice/pd-filter-threshold
# Solved: 2026-09-12

import pandas as pd


def big_payments(payments, min_amount):
    # Return the rows whose amount is at least min_amount.
    # Keep the original row order and row labels.
    return payments[payments["amount"] >= min_amount]

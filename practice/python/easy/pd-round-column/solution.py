# Xom Data · Round a share column before printing the report
# Problem: https://xomdata.com/practice/pd-round-column
# Solved: 2026-09-12

import pandas as pd


def round_column(table, column):
    # Round one column to 2 decimal places, leaving the input table untouched.
    result = table.copy()
    result[column] = result[column].round(2)
    return result

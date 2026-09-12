# Xom Data · Fill the blanks of one column with a default
# Problem: https://xomdata.com/practice/pd-fill-missing
# Solved: 2026-09-12

import pandas as pd


def fill_missing(table, column, value):
    # Fill the empty cells of one column, leaving the input table untouched.
    result = table.copy()
    result[column] = result[column].fillna(value)
    return result

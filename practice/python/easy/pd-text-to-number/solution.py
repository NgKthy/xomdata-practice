# Xom Data · The amount column arrived as text with commas
# Problem: https://xomdata.com/practice/pd-text-to-number
# Solved: 2026-09-12

import pandas as pd


def amounts_to_number(table, column):
    # Strip the thousands separators, then turn the column into integers.
    result = table.copy()
    result[column] = result[column].str.replace(",", "", regex = False).astype(int)
    return result

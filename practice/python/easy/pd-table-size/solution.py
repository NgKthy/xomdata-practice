# Xom Data · How many rows and columns did we get
# Problem: https://xomdata.com/practice/pd-table-size
# Solved: 2026-09-12

import pandas as pd


def table_size(table):
    return (table.shape[0], table.shape[1])

# Xom Data · Fill in a default for a missing field
# Problem: https://xomdata.com/practice/py-fill-missing
# Solved: 2026-10-30

def fill_missing(rows, field, default):
    result = []
    for row in rows:
        new_row = dict(row)
        if field not in new_row:
            new_row[field] = default
        result.append(new_row)
    return result

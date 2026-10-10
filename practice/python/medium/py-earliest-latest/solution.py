# Xom Data · Earliest and latest date in the ledger
# Problem: https://xomdata.com/practice/py-earliest-latest
# Solved: 2026-10-10

def date_span(dates):
    if not dates:
        return None
    return (min(dates), max(dates))

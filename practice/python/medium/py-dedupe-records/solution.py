# Xom Data · Drop duplicates, keep the newest record
# Problem: https://xomdata.com/practice/py-dedupe-records
# Solved: 2026-10-10

def dedupe(rows, key):
    order = []
    latest = {}
    
    for row in rows:
        k = row[key]
        if k not in latest:
            order.append(k)
        latest[k] = row
    
    return [latest[k] for k in order]

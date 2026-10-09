# Xom Data · Split a list into batches
# Problem: https://xomdata.com/practice/py-chunk-list
# Solved: 2026-10-09

def chunk(items, size):
    return [items[i:i + size] for i in range(0, len(items), size)]

# Xom Data · Boxes needed to pack the goods
# Problem: https://xomdata.com/practice/py-boxes-needed
# Solved: 2026-10-08

def boxes_needed(items, capacity):
    return (items + capacity - 1) // capacity

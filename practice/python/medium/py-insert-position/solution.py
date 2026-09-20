# Xom Data · Insertion point that keeps a list sorted
# Problem: https://xomdata.com/practice/py-insert-position
# Solved: 2026-09-20

def insert_position(values, target):
    left, right = 0, len(values)

    while left < right:
        mid = (left + right) // 2

        if values[mid] < target:
            left = mid + 1
        else:
            right = mid

    return left

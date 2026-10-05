# Xom Data · Kth largest element
# Problem: https://xomdata.com/practice/py-kth-largest
# Solved: 2026-10-05

def kth_largest(numbers, k):
    return sorted(numbers, reverse=True)[k - 1]

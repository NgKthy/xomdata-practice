# Xom Data · Merge two sorted lists
# Problem: https://xomdata.com/practice/py-merge-sorted
# Solved: 2026-10-09

def merge_sorted(a, b):
    i, j = 0, 0
    result = []
    
    while i < len(a) and j < len(b):
        if a[i] <= b[j]:
            result.append(a[i])
            i += 1
        else:
            result.append(b[j])
            j += 1
    
    result.extend(a[i:])
    result.extend(b[j:])
    
    return result

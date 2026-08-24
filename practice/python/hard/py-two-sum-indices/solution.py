# Xom Data · Two sum
# Problem: https://xomdata.com/practice/py-two-sum-indices
# Solved: 2026-08-24

def two_sum(numbers, target):
    from bisect import bisect_right

    pos = {}
    for idx, val in enumerate(numbers):
        pos.setdefault(val, []).append(idx)

    for i, val in enumerate(numbers):
        complement = target - val
        if complement in pos:
            lst = pos[complement]
            j_idx = bisect_right(lst, i)
            if j_idx < len(lst):
                return [i, lst[j_idx]]
    
    return []

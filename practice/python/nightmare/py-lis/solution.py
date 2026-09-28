# Xom Data · Longest increasing subsequence
# Problem: https://xomdata.com/practice/py-lis
# Solved: 2026-09-28

import bisect

def lis_length(numbers):
    tails = []
    for x in numbers:
        idx = bisect.bisect_left(tails, x)
        if idx == len(tails):
            tails.append(x)
        else:
            tails[idx] = x
    return len(tails)

# Xom Data · First unique character
# Problem: https://xomdata.com/practice/py-first-non-repeating
# Solved: 2026-09-18

from collections import Counter

def first_non_repeating(s):
    counts = Counter(s)

    for i, ch in enumerate(s):
        if counts[ch] == 1:
            return i

    return -1

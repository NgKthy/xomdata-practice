# Xom Data · Most frequent character
# Problem: https://xomdata.com/practice/py-most-frequent
# Solved: 2026-08-24

def most_frequent(text):
    freq = {}
    for ch in text:
        freq[ch] = freq.get(ch, 0) + 1
    max_count = max(freq.values())
    for ch in text:
        if freq[ch] == max_count:
            return ch

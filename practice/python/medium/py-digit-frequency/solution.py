# Xom Data · Digit frequency
# Problem: https://xomdata.com/practice/py-digit-frequency
# Solved: 2026-10-09

def digit_frequency(number):
    freq = {}
    for ch in str(number):
        freq[ch] = freq.get(ch, 0) + 1
    return freq

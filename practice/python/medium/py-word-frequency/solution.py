# Xom Data · Word frequency count in text
# Problem: https://xomdata.com/practice/py-word-frequency
# Solved: 2026-08-24

def word_frequency(text):
    freq = {}
    for word in text.split():
        if word not in freq:
            freq[word] = 0
        freq[word] += 1
    return freq

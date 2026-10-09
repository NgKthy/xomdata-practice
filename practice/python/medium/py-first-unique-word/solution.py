# Xom Data · First non-repeating word in a paragraph
# Problem: https://xomdata.com/practice/py-first-unique-word
# Solved: 2026-10-09

def first_unique(text):
    words = text.split()
    freq = {}
    for word in words:
        key = word.lower()
        freq[key] = freq.get(key, 0) + 1

    for word in words:
        if freq[word.lower()] == 1:
            return word

    return None

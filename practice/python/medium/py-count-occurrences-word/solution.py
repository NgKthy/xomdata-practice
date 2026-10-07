# Xom Data · Count word occurrences
# Problem: https://xomdata.com/practice/py-count-occurrences-word
# Solved: 2026-10-07

def count_word(text, target):
    target = target.lower()
    return sum(1 for word in text.lower().split() if word == target)

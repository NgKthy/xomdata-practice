# Xom Data · Longest word in a sentence
# Problem: https://xomdata.com/practice/py-longest-word
# Solved: 2026-10-09

def longest_word(sentence):
    return max(sentence.split(), key=len)

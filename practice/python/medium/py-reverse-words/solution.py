# Xom Data · Reverse words in a string
# Problem: https://xomdata.com/practice/py-reverse-words
# Solved: 2026-08-26

def reverse_words(sentence):
    words = sentence.split()
    return ' '.join(words[::-1])

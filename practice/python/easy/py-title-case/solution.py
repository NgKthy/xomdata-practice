# Xom Data · Normalize customer names
# Problem: https://xomdata.com/practice/py-title-case
# Solved: 2026-10-07

def capitalize_words(text):
    return ' '.join(word.capitalize() for word in text.split())

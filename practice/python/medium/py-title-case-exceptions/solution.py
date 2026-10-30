# Xom Data · Capitalise a book title the publisher's way
# Problem: https://xomdata.com/practice/py-title-case-exceptions
# Solved: 2026-10-30

def book_title(text):
    small_words = {"of", "and", "the", "in", "on"}
    words = text.split()
    result = []
    
    for i, word in enumerate(words):
        if i == 0 or word not in small_words:
            result.append(word[0].upper() + word[1:])
        else:
            result.append(word)
    
    return ' '.join(result)

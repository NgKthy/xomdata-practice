# Xom Data · Generate initials
# Problem: https://xomdata.com/practice/py-initials
# Solved: 2026-10-06

def get_initials(full_name):
    return ''.join(word[0].upper() for word in full_name.split())

# Xom Data · Valid parentheses
# Problem: https://xomdata.com/practice/py-balanced-brackets
# Solved: 2026-08-24

def is_balanced(text):
    count = 0
    for ch in text:
        if ch == '(':
            count += 1
        elif ch == ')':
            count -= 1
            if count < 0:
                return False
    return count == 0

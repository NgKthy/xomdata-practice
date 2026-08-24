# Xom Data · Valid nested parentheses
# Problem: https://xomdata.com/practice/py-valid-brackets
# Solved: 2026-08-24

def is_valid(s):
    open_brackets = set('([{')
    pairs = {')': '(', ']': '[', '}': '{'}
    stack = []
    
    for char in s:
        if char in open_brackets:
            stack.append(char)
        else:
            if not stack or stack[-1] != pairs[char]:
                return False
            stack.pop()
    
    return not stack

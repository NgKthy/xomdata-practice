# Xom Data · Jump game
# Problem: https://xomdata.com/practice/py-jump-game
# Solved: 2026-10-09

def can_jump(numbers):
    max_reach = 0
    for i, steps in enumerate(numbers):
        if i > max_reach:
            return False
        max_reach = max(max_reach, i + steps)
    return True

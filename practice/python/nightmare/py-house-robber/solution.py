# Xom Data · House robber
# Problem: https://xomdata.com/practice/py-house-robber
# Solved: 2026-09-28

def rob(numbers):
    prev = 0  
    curr = 0  
    for num in numbers:
        prev, curr = curr, max(curr, prev + num)
    return curr

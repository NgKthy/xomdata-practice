# Xom Data · Majority element
# Problem: https://xomdata.com/practice/py-majority-element
# Solved: 2026-09-29

def majority(numbers):
    if not numbers:
        return None
    
    candidate = None
    count = 0
    for num in numbers:
        if count == 0:
            candidate = num
            count = 1
        elif num == candidate:
            count += 1
        else:
            count -= 1
    
    if numbers.count(candidate) > len(numbers) // 2:
        return candidate
    return None

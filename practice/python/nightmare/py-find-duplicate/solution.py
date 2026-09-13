# Xom Data · Find the duplicate number
# Problem: https://xomdata.com/practice/py-find-duplicate
# Solved: 2026-09-13

def find_duplicate(numbers):
    slow = numbers[0]
    fast = numbers[0]

    while True:
        slow = numbers[slow]
        fast = numbers[numbers[fast]]
        if slow == fast:
            break

    slow = numbers[0]
    while slow != fast:
        slow = numbers[slow]
        fast = numbers[fast]

    return slow

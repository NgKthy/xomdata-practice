# Xom Data · Longest consecutive sequence
# Problem: https://xomdata.com/practice/py-longest-consecutive
# Solved: 2026-09-28

def longest_consecutive(numbers):
    num_set = set(numbers)
    longest = 0

    for num in num_set:
        if num - 1 not in num_set:
            current = num
            length = 1

            while current + 1 in num_set:
                current += 1
                length += 1

            longest = max(longest, length)

    return longest

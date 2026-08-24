# Xom Data · Count pairs with a target sum
# Problem: https://xomdata.com/practice/py-two-sum-count
# Solved: 2026-08-24

def count_pairs(numbers, target):
    freq = {}
    count = 0
    for num in numbers:
        complement = target - num
        if complement in freq:
            count += freq[complement]
        freq[num] = freq.get(num, 0) + 1
    return count

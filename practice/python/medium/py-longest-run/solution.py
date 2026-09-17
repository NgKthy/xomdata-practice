# Xom Data · Longest continuous increasing subsequence
# Problem: https://xomdata.com/practice/py-longest-run
# Solved: 2026-09-17

def longest_increasing_run(numbers):
    if not numbers:
        return 0

    max_len = 1
    current_len = 1

    for i in range(1, len(numbers)):
        if numbers[i] > numbers[i - 1]:
            current_len += 1
            max_len = max(max_len, current_len)
        else:
            current_len = 1

    return max_len

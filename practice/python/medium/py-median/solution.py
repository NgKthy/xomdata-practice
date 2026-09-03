# Xom Data · Median of a list
# Problem: https://xomdata.com/practice/py-median
# Solved: 2026-09-03

def median(numbers):
    sorted_nums = sorted(numbers)
    n = len(sorted_nums)
    if n % 2 == 1:
        return sorted_nums[n // 2]
    else:
        return round((sorted_nums[n // 2 - 1] + sorted_nums[n // 2]) / 2, 2)

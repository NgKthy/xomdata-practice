# Xom Data · Count students above the benchmark
# Problem: https://xomdata.com/practice/py-above-threshold
# Solved: 2026-10-07

def count_above(numbers, threshold):
    return sum(1 for x in numbers if x > threshold)

# Xom Data · Moving average over a window of k
# Problem: https://xomdata.com/practice/py-moving-average
# Solved: 2026-08-24

def moving_average(numbers, k):
    if len(numbers) < k:
        return []
    result = []
    for i in range(len(numbers) - k + 1):
        avg = sum(numbers[i:i+k]) / k
        result.append(round(avg, 2))
    return result

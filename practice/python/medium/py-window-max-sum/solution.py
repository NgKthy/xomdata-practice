# Xom Data · Best k-day window by total
# Problem: https://xomdata.com/practice/py-window-max-sum
# Solved: 2026-09-20

def best_window(values, k):
    n = len(values)

    if n < k:
        return None

    current_sum = sum(values[:k])
    best_sum = current_sum

    for i in range(k, n):
        current_sum += values[i] - values[i - k]
        if current_sum > best_sum:
            best_sum = current_sum
    
    return best_sum

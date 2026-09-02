# Xom Data · Sliding window maximum
# Problem: https://xomdata.com/practice/py-max-sliding-window
# Solved: 2026-09-02

from collections import deque
def max_sliding_window(numbers, k):
    if not numbers or k <= 0:
        return []

    result = []
    dq = deque()

    for i, num in enumerate(numbers):
        while dq and dq[0] <= i - k:
            dq.popleft()

        while dq and numbers[dq[-1]] < num:
            dq.pop()
        
        dq.append(i)

        if i >= k - 1:
            result.append(numbers[dq[0]])
    
    return result

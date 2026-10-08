# Xom Data · Integer square root
# Problem: https://xomdata.com/practice/py-integer-sqrt
# Solved: 2026-10-08

def int_sqrt(x):
    if x < 2:
        return x
    left, right = 1, x // 2
    ans = 0
    while left <= right:
        mid = (left + right) // 2
        if mid * mid <= x:
            ans = mid
            left = mid + 1
        else:
            right = mid - 1
    return ans

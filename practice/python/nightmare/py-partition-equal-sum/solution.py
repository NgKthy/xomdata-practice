# Xom Data · Partition equal subset sum
# Problem: https://xomdata.com/practice/py-partition-equal-sum
# Solved: 2026-09-17

def can_partition(numbers):
    total = sum(numbers)

    if total % 2 != 0:
        return False

    target = total // 2

    dp = [False] * (target + 1)
    dp[0] = True

    for num in numbers:
        for s in range(target, num - 1, -1):
            if dp[s - num]:
                dp[s] = True

    return dp[target]

# Xom Data · Burst balloons for maximum coins
# Problem: https://xomdata.com/practice/py-burst-balloons
# Solved: 2026-10-01

def max_coins(nums):
    arr = [1] + nums + [1]
    n = len(arr)
    
    dp = [[0] * n for _ in range(n)]
    
    for length in range(2, n):
        for i in range(0, n - length):
            j = i + length
            for k in range(i + 1, j):
                coins = arr[i] * arr[k] * arr[j]
                coins += dp[i][k] + dp[k][j]
                if coins > dp[i][j]:
                    dp[i][j] = coins
    
    return dp[0][n - 1]

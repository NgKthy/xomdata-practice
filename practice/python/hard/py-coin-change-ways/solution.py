# Xom Data · Coin change II
# Problem: https://xomdata.com/practice/py-coin-change-ways
# Solved: 2026-09-09

def count_ways(coins, amount):
    dp = [0] * (amount + 1)
    dp[0] = 1
    for coin in coins:
        for i in range(coin, amount + 1):
            dp[i] += dp[i - coin]
    return dp[amount]

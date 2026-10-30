# Xom Data · Best time to buy and sell stock
# Problem: https://xomdata.com/practice/py-max-profit
# Solved: 2026-10-30

def max_profit(prices):
    profit = 0
    for i in range(1, len(prices)):
        if prices[i] > prices[i - 1]:
            profit += prices[i] - prices[i - 1]
    return profit

# Xom Data · Candy distribution by rank
# Problem: https://xomdata.com/practice/py-candy
# Solved: 2026-10-01

def min_candies(ratings):
    if not ratings:
        return 0
    
    n = len(ratings)
    candies = [1] * n
    
    for i in range(1, n):
        if ratings[i] > ratings[i - 1]:
            candies[i] = candies[i - 1] + 1
    
    for i in range(n - 2, -1, -1):
        if ratings[i] > ratings[i + 1]:
            candies[i] = max(candies[i], candies[i + 1] + 1)
    
    return sum(candies)

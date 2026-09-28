# Xom Data · Minimum path sum
# Problem: https://xomdata.com/practice/py-min-path-sum
# Solved: 2026-09-28

def min_path_sum(grid):
    if not grid or not grid[0]:
        return 0
    
    m, n = len(grid), len(grid[0])
    dp = grid[0][:]  
    
    for j in range(1, n):
        dp[j] += dp[j - 1]
    
    for i in range(1, m):
        dp[0] += grid[i][0]  
        for j in range(1, n):
            dp[j] = min(dp[j], dp[j - 1]) + grid[i][j]
    
    return dp[-1]

# Xom Data · Interleaving string
# Problem: https://xomdata.com/practice/py-interleave-string
# Solved: 2026-10-09

def is_interleave(s1, s2, s3):
    n1, n2, n3 = len(s1), len(s2), len(s3)
    if n1 + n2 != n3:
        return False
    
    dp = [[False] * (n2 + 1) for _ in range(n1 + 1)]
    dp[0][0] = True
    
    for i in range(n1 + 1):
        for j in range(n2 + 1):
            if i > 0 and s1[i - 1] == s3[i + j - 1]:
                dp[i][j] = dp[i][j] or dp[i - 1][j]
            if j > 0 and s2[j - 1] == s3[i + j - 1]:
                dp[i][j] = dp[i][j] or dp[i][j - 1]
    
    return dp[n1][n2]

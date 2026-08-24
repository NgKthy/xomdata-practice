# Xom Data · Sentence segmentation with a dictionary
# Problem: https://xomdata.com/practice/py-word-break
# Solved: 2026-08-24

def word_break(s, words):
    word_set = set(words)
    dp = [False] * (len(s) + 1)
    dp[0] = True

    for i in range(1, len(s) + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break
    
    return dp[len(s)]

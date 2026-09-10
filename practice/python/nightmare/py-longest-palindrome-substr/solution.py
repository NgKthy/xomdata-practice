# Xom Data · Longest palindromic substring
# Problem: https://xomdata.com/practice/py-longest-palindrome-substr
# Solved: 2026-09-10

def longest_palindrome(s):
    if not s:
        return ""
    
    start = 0
    max_len = 1

    def expand(left, right):
        while left >= 0  and right < len(s) and s[left] == s[right]:
            left -= 1
            right += 1
        return left + 1, right - left - 1
    
    for i in range(len(s)):
        l, length = expand(i, i)
        if length > max_len:
            start = l
            max_len = length

        l, length = expand(i, i + 1)
        if length > max_len:
            start = l
            max_len = length
    
    return s[start:start + max_len]

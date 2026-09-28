# Xom Data · Minimum window substring
# Problem: https://xomdata.com/practice/py-min-window-substring
# Solved: 2026-09-28

from collections import Counter

def min_window(s, t):
    if not s or not t:
        return ""
    
    need = Counter(t)
    missing = len(t)
    left = 0
    min_len = float('inf')
    min_start = 0
    
    for right, ch in enumerate(s):
        if need.get(ch, 0) > 0:
            missing -= 1
        need[ch] = need.get(ch, 0) - 1
        
        while missing == 0:
            if right - left + 1 < min_len:
                min_len = right - left + 1
                min_start = left
            
            left_ch = s[left]
            need[left_ch] = need.get(left_ch, 0) + 1
            if need[left_ch] > 0:
                missing += 1
            left += 1
    
    return "" if min_len == float('inf') else s[min_start:min_start + min_len]

# Xom Data · Roman to integer
# Problem: https://xomdata.com/practice/py-roman-to-int
# Solved: 2026-10-05

def roman_to_int(s):
    roman = {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000
    }
    
    total = 0
    n = len(s)
    
    for i in range(n):
        value = roman[s[i]]
        if i + 1 < n and value < roman[s[i + 1]]:
            total -= value
        else:
            total += value
    
    return total

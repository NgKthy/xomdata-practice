# Xom Data · Multiply strings
# Problem: https://xomdata.com/practice/py-multiply-strings
# Solved: 2026-09-28

def multiply_strings(num1, num2):
    if num1 == "0" or num2 == "0":
        return "0"
    
    n1, n2 = len(num1), len(num2)
    res = [0] * (n1 + n2)
    
    for i in range(n1 - 1, -1, -1):
        d1 = ord(num1[i]) - ord('0')
        for j in range(n2 - 1, -1, -1):
            d2 = ord(num2[j]) - ord('0')
            mul = d1 * d2
            
            p1 = i + j
            p2 = i + j + 1
            
            total = mul + res[p2]
            res[p2] = total % 10
            res[p1] += total // 10
    
    idx = 0
    while idx < len(res) and res[idx] == 0:
        idx += 1
    
    return ''.join(str(d) for d in res[idx:]) if idx < len(res) else "0"

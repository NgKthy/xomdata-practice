# Xom Data · Add binary
# Problem: https://xomdata.com/practice/py-add-binary
# Solved: 2026-09-28

def add_binary(a, b):
    i, j = len(a) - 1, len(b) - 1
    carry = 0
    result = []
    
    while i >= 0 or j >= 0 or carry:
        total = carry
        if i >= 0:
            total += int(a[i])
            i -= 1
        if j >= 0:
            total += int(b[j])
            j -= 1
        
        result.append(str(total % 2))
        carry = total // 2
    
    return ''.join(reversed(result))

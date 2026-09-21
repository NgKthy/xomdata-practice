# Xom Data · Gray code
# Problem: https://xomdata.com/practice/py-gray-code
# Solved: 2026-09-21

def gray_code(n):
    return [i ^ (i >> 1) for i in range(1 << n)]

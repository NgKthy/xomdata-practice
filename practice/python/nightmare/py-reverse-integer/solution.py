# Xom Data · Reverse integer
# Problem: https://xomdata.com/practice/py-reverse-integer
# Solved: 2026-10-09

def reverse_integer(x):
    sign = -1 if x < 0 else 1
    rev = int(str(abs(x))[::-1]) * sign

    if rev < -2**31 or rev > 2**31 - 1:
        return 0
    return rev

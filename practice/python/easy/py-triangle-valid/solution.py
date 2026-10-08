# Xom Data · Check triangle sides
# Problem: https://xomdata.com/practice/py-triangle-valid
# Solved: 2026-10-08

def is_triangle(a, b, c):
    return a + b > c and a + c > b and b + c > a

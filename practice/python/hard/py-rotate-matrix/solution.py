# Xom Data · Rotate image
# Problem: https://xomdata.com/practice/py-rotate-matrix
# Solved: 2026-09-17

def rotate_90(matrix):
    if not matrix:
        return []

    n = len(matrix)
    rotated = [[0] * n for _ in range(n)]

    for i in range(n):
        for j in range(n):
            rotated[j][n - 1 - i] = matrix[i][j]

    return rotated

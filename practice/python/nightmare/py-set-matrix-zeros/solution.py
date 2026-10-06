# Xom Data · Set matrix zeroes
# Problem: https://xomdata.com/practice/py-set-matrix-zeros
# Solved: 2026-10-06

def set_zeroes(matrix):
    if not matrix or not matrix[0]:
        return matrix
    
    rows = len(matrix)
    cols = len(matrix[0])
    
    zero_rows = set()
    zero_cols = set()
    
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 0:
                zero_rows.add(i)
                zero_cols.add(j)
    
    result = [row[:] for row in matrix]
    
    for i in range(rows):
        for j in range(cols):
            if i in zero_rows or j in zero_cols:
                result[i][j] = 0
    
    return result

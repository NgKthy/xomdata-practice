# Xom Data · Pascal's triangle
# Problem: https://xomdata.com/practice/py-pascal-triangle
# Solved: 2026-09-20

def pascal(n):
    if n <= 0:
        return []

    result = [[1]]

    for i in range(1, n):
        prev = result[-1]
        row = [1]

        for j in range(1, i):
            row.append(prev[j - 1] + prev[j])

        row.append(1)
        result.append(row)

    return result

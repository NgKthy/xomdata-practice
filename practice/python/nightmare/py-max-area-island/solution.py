# Xom Data · Max area of island
# Problem: https://xomdata.com/practice/py-max-area-island
# Solved: 2026-09-29

def max_area(grid):
    if not grid or not grid[0]:
        return 0
    
    rows, cols = len(grid), len(grid[0])
    visited = set()
    max_area = 0
    
    for i in range(rows):
        for j in range(cols):
            if grid[i][j] == 1 and (i, j) not in visited:
                area = 0
                stack = [(i, j)]
                visited.add((i, j))
                
                while stack:
                    x, y = stack.pop()
                    area += 1
                    
                    for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < rows and 0 <= ny < cols:
                            if grid[nx][ny] == 1 and (nx, ny) not in visited:
                                visited.add((nx, ny))
                                stack.append((nx, ny))
                
                max_area = max(max_area, area)
    
    return max_area

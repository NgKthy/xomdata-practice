# Xom Data · Number of islands
# Problem: https://xomdata.com/practice/py-num-islands
# Solved: 2026-09-17

def num_islands(grid):
    if not grid or not grid[0]:
        return 0

    rows = len(grid)
    cols = len(grid[0])
    visited = set()
    count = 0

    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    for r in range(rows):
        for c in range(cols):
            if grid[r][c] == 1 and (r, c) not in visited:
                count += 1

                stack = [(r, c)]
                visited.add((r, c))

                while stack:
                    x, y = stack.pop()

                    for dx, dy in directions:
                        nx, ny = x + dx, y + dy

                        if (
                            0 <= nx < rows
                            and 0 <= ny < cols
                            and grid[nx][ny] == 1
                            and (nx, ny) not in visited
                        ):
                            visited.add((nx, ny))
                            stack.append((nx, ny))

    return count

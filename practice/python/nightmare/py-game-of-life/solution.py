# Xom Data · Game of life
# Problem: https://xomdata.com/practice/py-game-of-life
# Solved: 2026-10-09

def game_of_life(board):
    if not board or not board[0]:
        return []
    
    rows, cols = len(board), len(board[0])
    result = [[0] * cols for _ in range(rows)]
    
    for i in range(rows):
        for j in range(cols):
            live_neighbors = 0
            for di in (-1, 0, 1):
                for dj in (-1, 0, 1):
                    if di == 0 and dj == 0:
                        continue
                    ni, nj = i + di, j + dj
                    if 0 <= ni < rows and 0 <= nj < cols:
                        live_neighbors += board[ni][nj]
            
            if board[i][j] == 1:
                if live_neighbors == 2 or live_neighbors == 3:
                    result[i][j] = 1
            else:
                if live_neighbors == 3:
                    result[i][j] = 1
    
    return result

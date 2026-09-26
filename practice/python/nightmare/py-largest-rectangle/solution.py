# Xom Data · Largest rectangle in histogram
# Problem: https://xomdata.com/practice/py-largest-rectangle
# Solved: 2026-09-26

def largest_rectangle(heights):
    stack = []
    max_area = 0
    n = len(heights)

    for i in range(n + 1):
        h = heights[i] if i < n else 0
        while stack and heights[stack[-1]] > h:
            height = heights[stack.pop()]
            width = i if not stack else i - stack[-1] - 1
            max_area = max(max_area, height * width)
        stack.append(i)

    return max_area

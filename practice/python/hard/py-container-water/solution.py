# Xom Data · Container with most water
# Problem: https://xomdata.com/practice/py-container-water
# Solved: 2026-09-09

def max_area(heights):
    if len(heights) < 2:
        return 0
    
    left, right = 0, len(heights) - 1
    max_water = 0
    
    while left < right:
        width = right - left
        height = min(heights[left], heights[right])
        area = width * height
        max_water = max(max_water, area)
        
        if heights[left] < heights[right]:
            left += 1
        else:
            right -= 1
    
    return max_water

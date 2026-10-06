# Xom Data · Maximum circular subarray sum
# Problem: https://xomdata.com/practice/py-kadane-circular
# Solved: 2026-10-06

def max_circular(numbers):
    def kadane_max(arr):
        max_ending = max_so_far = arr[0]
        for x in arr[1:]:
            max_ending = max(x, max_ending + x)
            max_so_far = max(max_so_far, max_ending)
        return max_so_far
    
    def kadane_min(arr):
        min_ending = min_so_far = arr[0]
        for x in arr[1:]:
            min_ending = min(x, min_ending + x)
            min_so_far = min(min_so_far, min_ending)
        return min_so_far
    
    max_sub = kadane_max(numbers)
    if max_sub < 0:
        return max_sub
    
    total = sum(numbers)
    min_sub = kadane_min(numbers)
    return max(max_sub, total - min_sub)

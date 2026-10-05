# Xom Data · House robber II
# Problem: https://xomdata.com/practice/py-house-robber-circle
# Solved: 2026-10-05

def rob_circle(nums):
    if not nums:
        return 0
    if len(nums) == 1:
        return nums[0]
    
    def rob_line(arr):
        prev, curr = 0, 0
        for x in arr:
            prev, curr = curr, max(curr, prev + x)
        return curr
    
    return max(rob_line(nums[:-1]), rob_line(nums[1:]))

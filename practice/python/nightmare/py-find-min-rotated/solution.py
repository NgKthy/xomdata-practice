# Xom Data · Find minimum in rotated sorted array
# Problem: https://xomdata.com/practice/py-find-min-rotated
# Solved: 2026-09-13

def find_min(nums):
    left, right = 0, len(nums) - 1

    while left < right:
        mid = (left + right) // 2

        if nums[mid] > nums[right]:
            left = mid + 1
        else:
            right = mid

    return nums[left]

# Xom Data · Next permutation
# Problem: https://xomdata.com/practice/py-next-permutation
# Solved: 2026-09-17

def next_permutation(nums):
    nums = nums[:]
    n = len(nums)

    if n <= 1:
        return nums

    i = n - 2
    while i >= 0 and nums[i] >= nums[i + 1]:
        i -= 1

    if i >= 0:
        j = n - 1
        while nums[j] <= nums[i]:
            j -= 1

        nums[i], nums[j] = nums[j], nums[i]

    left, right = i + 1, n - 1
    while left < right:
        nums[left], nums[right] = nums[right], nums[left]
        left += 1
        right -= 1

    return nums

# Xom Data · Search in rotated sorted array
# Problem: https://xomdata.com/practice/py-search-rotated
# Solved: 2026-08-27

def search(numbers, target):
    if not numbers:
        return -1

    left, right = 0, len(numbers) - 1

    while left <= right:
        mid = (left + right) // 2

        if numbers[mid] == target:
            return mid

        if numbers[left] <= numbers[mid]:
            if numbers[left] <= target < numbers[mid]:
                right = mid - 1
            else:
                left = mid + 1
        else:
            if numbers[mid] < target <= numbers[right]:
                left = mid + 1
            else:
                right = mid - 1
    
    return -1

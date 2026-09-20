# Xom Data · 3Sum
# Problem: https://xomdata.com/practice/py-3sum-count
# Solved: 2026-09-20

def count_triplets(numbers):
    numbers.sort()
    n = len(numbers)
    count = 0

    for i in range(n - 2):
        if i > 0 and numbers[i] == numbers[i - 1]:
            continue

        left = i + 1
        right = n - 1

        while left < right:
            total = numbers[i] + numbers[left] + numbers[right]

            if total == 0:
                count += 1

                left += 1
                right -= 1

                while left < right and numbers[left] == numbers[left - 1]:
                    left += 1
                while left < right and numbers[right] == numbers[right + 1]:
                    right -= 1

            elif total < 0:
                left += 1
            else:
                right -= 1

    return count

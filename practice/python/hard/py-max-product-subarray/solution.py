# Xom Data · Maximum product subarray
# Problem: https://xomdata.com/practice/py-max-product-subarray
# Solved: 2026-09-20

def max_product(numbers):
    max_prod = numbers[0]
    min_prod = numbers[0]
    result = numbers[0]

    for num in numbers[1:]:
        if num < 0:
            max_prod, min_prod = min_prod, max_prod

        max_prod = max(num, max_prod * num)
        min_prod = min(num, min_prod * num)

        result = max(result, max_prod)

    return result

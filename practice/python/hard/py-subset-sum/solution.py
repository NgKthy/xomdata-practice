# Xom Data · Subset sum exists
# Problem: https://xomdata.com/practice/py-subset-sum
# Solved: 2026-09-17

def can_sum(numbers, target):
    if target == 0:
        return True

    reachable = {0}  

    for num in numbers:
        if num > target:
            continue

        for s in list(reachable):
            new_sum = s + num
            if new_sum <= target:
                reachable.add(new_sum)

        if target in reachable:
            return True

    return target in reachable

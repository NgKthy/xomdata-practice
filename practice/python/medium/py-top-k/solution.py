# Xom Data · Top K largest elements
# Problem: https://xomdata.com/practice/py-top-k
# Solved: 2026-08-24

def top_k(numbers, k):
    if k <= 0:
        return []
    sorted_nums = sorted(numbers, reverse = True)
    return sorted_nums[:k]

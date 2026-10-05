# Xom Data · Position of the priciest item in the table
# Problem: https://xomdata.com/practice/py-index-of-max
# Solved: 2026-10-05

def index_of_max(prices):
    if not prices:
        return -1
    max_index = 0
    for i in range(1, len(prices)):
        if prices[i] > prices[max_index]:
            max_index = i
    return max_index

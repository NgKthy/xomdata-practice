# Xom Data · Total and order count per region
# Problem: https://xomdata.com/practice/py-aggregate-two-fields
# Solved: 2026-10-30

def summarize(orders):
    result = {}
    for order in orders:
        region = order["region"]
        amount = order["amount"]
        if region not in result:
            result[region] = {"total": 0, "count": 0}
        result[region]["total"] += amount
        result[region]["count"] += 1
    return result

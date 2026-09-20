# Xom Data · Consolidate inventory across warehouses
# Problem: https://xomdata.com/practice/py-inventory-merge
# Solved: 2026-09-20

def merge_inventory(warehouses):
    result = {}

    for warehouse in warehouses:
        for product, quantity in warehouse.items():
            if product in result:
                result[product] += quantity
            else:
                result[product] = quantity

    return result

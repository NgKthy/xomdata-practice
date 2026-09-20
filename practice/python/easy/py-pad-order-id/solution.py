# Xom Data · Pad an order id with leading zeros
# Problem: https://xomdata.com/practice/py-pad-order-id
# Solved: 2026-09-20

def pad_order_id(number):
    return str(number).zfill(5)

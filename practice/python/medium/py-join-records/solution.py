# Xom Data · Join two record lists by id
# Problem: https://xomdata.com/practice/py-join-records
# Solved: 2026-09-17

def join_by_id(orders, customers):
    customer_map = {c["id"]: c["name"] for c in customers}

    result = []
    for order in orders:
        customer_id = order["customer_id"]

        if customer_id in customer_map:
            result.append({
                "name": customer_map[customer_id],
                "amount": order["amount"]
            })

    return result

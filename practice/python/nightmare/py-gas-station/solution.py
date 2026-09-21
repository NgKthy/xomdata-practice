# Xom Data · Gas station
# Problem: https://xomdata.com/practice/py-gas-station
# Solved: 2026-09-21

def can_complete(gas, cost):
    total_gas = sum(gas)
    total_cost = sum(cost)

    if total_gas < total_cost:
        return -1

    start = 0
    tank = 0

    for i in range(len(gas)):
        tank += gas[i] - cost[i]

        if tank < 0:
            start = i + 1
            tank = 0

    return start

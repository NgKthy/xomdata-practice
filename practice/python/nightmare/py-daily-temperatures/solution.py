# Xom Data · Daily temperatures
# Problem: https://xomdata.com/practice/py-daily-temperatures
# Solved: 2026-09-18

def daily_temperatures(temps):
    n = len(temps)
    result = [0] * n
    stack = []

    for i, t in enumerate(temps):
        while stack and t > temps[stack[-1]]:
            prev = stack.pop()
            result[prev] = i - prev
        stack.append(i)

    return result

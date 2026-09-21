# Xom Data · Average score by class
# Problem: https://xomdata.com/practice/py-average-per-group
# Solved: 2026-09-21

def average_per_group(pairs):
    stats = {}

    for group, score in pairs:
        if group not in stats:
            stats[group] = [0, 0]
        stats[group][0] += score
        stats[group][1] += 1

    result = {}
    for group, (total, count) in stats.items():
        result[group] = round(total / count, 2)
    
    return result

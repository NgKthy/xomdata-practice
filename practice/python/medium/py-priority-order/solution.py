# Xom Data · Order the support ticket queue
# Problem: https://xomdata.com/practice/py-priority-order
# Solved: 2026-09-18

def sort_by_priority(tickets):
    priority = {"high": 0, "medium": 1, "low": 2}

    sorted_tickets = sorted(tickets, key = lambda x: priority[x[1]])

    return [code for code, _ in sorted_tickets]

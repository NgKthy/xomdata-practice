# Xom Data · Split a bill into whole dong
# Problem: https://xomdata.com/practice/py-split-bill
# Solved: 2026-09-26

def split_bill(total, people):
    return (total // people, total % people)

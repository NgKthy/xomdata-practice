# Xom Data · Did the whole team clear the first round
# Problem: https://xomdata.com/practice/py-all-passed
# Solved: 2026-08-28

def all_passed(scores, pass_mark):
    return all(score >= pass_mark for score in scores)

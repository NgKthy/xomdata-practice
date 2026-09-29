# Xom Data · Normalize phone numbers
# Problem: https://xomdata.com/practice/py-normalize-phone
# Solved: 2026-09-29

def normalize(phone):
    return ''.join(ch for ch in phone if ch.isdigit())

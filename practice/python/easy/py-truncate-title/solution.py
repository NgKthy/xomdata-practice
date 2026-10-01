# Xom Data · Shorten an over-long title on an article card
# Problem: https://xomdata.com/practice/py-truncate-title
# Solved: 2026-10-01

def shorten(text, limit):
    if len(text) > limit:
        return text[:limit] + "..."
    return text

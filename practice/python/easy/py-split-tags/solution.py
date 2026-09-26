# Xom Data · Split a tag list out of one input box
# Problem: https://xomdata.com/practice/py-split-tags
# Solved: 2026-09-26

def split_tags(text):
    return [tag.strip() for tag in text.split(',') if tag.strip()]

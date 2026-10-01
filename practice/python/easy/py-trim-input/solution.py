# Xom Data · Clean up stray spaces in a list of names
# Problem: https://xomdata.com/practice/py-trim-input
# Solved: 2026-10-01

def clean_names(raw_list):
    return [name.strip() for name in raw_list]

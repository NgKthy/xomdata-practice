# Xom Data · Flip a code-to-name lookup table
# Problem: https://xomdata.com/practice/py-invert-mapping
# Solved: 2026-10-07

def invert(mapping):
    return {value: key for key, value in mapping.items()}

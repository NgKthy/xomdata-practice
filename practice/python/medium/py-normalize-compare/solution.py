# Xom Data · Match product names despite small differences
# Problem: https://xomdata.com/practice/py-normalize-compare
# Solved: 2026-09-29

import re

def same_product(a, b):
    def normalize(s):
        s = s.lower()

        s = re.sub(r'[.,-]', ' ', s)

        s = re.sub(r'\s+', ' ', s).strip()
        return s

    return normalize(a) == normalize(b)

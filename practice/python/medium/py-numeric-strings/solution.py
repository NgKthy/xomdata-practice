# Xom Data · Turn a text column into usable numbers
# Problem: https://xomdata.com/practice/py-numeric-strings
# Solved: 2026-10-30

def to_numbers(values):
    result = []
    for v in values:
        s = v.replace(",", "").strip()
        try:
            if s == "":
                result.append(0)
            else:
                result.append(int(s))
        except ValueError:
            result.append(0)
    return result

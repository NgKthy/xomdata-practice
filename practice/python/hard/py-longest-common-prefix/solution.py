# Xom Data · Longest common prefix
# Problem: https://xomdata.com/practice/py-longest-common-prefix
# Solved: 2026-09-18

def longest_common_prefix(words):
    if not words:
        return ""

    prefix = words[0]

    for word in words[1:]:
        while not word.startswith(prefix):
            prefix = prefix[:-1]
            if prefix == "":
                return ""

    return prefix

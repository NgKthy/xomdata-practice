# Xom Data · Group anagrams
# Problem: https://xomdata.com/practice/py-anagram-groups
# Solved: 2026-08-24

def group_anagrams(words):
    groups = {}
    for word in words:
        key = tuple(sorted(word))
        if key not in groups:
            groups[key] = []
        groups[key].append(word)
    return list(groups.values())

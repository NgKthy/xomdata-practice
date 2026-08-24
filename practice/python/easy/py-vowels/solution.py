# Xom Data · Count vowels in a name
# Problem: https://xomdata.com/practice/py-vowels
# Solved: 2026-08-24

def count_vowels(name):
    vowels = {'a', 'e', 'i', 'o', 'u'}
    count = 0
    for char in name.lower():
        if char in vowels:
            count += 1
    return count

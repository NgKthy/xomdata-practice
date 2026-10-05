# Xom Data · Scramble a promo code with a letter shift
# Problem: https://xomdata.com/practice/py-caesar-shift
# Solved: 2026-10-05

def shift_code(text, shift):
    result = []
    for ch in text:
        if 'a' <= ch <= 'z':
            new_ch = chr((ord(ch) - ord('a') + shift) % 26 + ord('a'))
            result.append(new_ch)
        else:
            result.append(ch)
    return ''.join(result)

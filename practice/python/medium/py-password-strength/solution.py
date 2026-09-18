# Xom Data · Check strong password
# Problem: https://xomdata.com/practice/py-password-strength
# Solved: 2026-09-18

def is_strong(password):
    if len(password) < 8:
        return False
    
    has_digit = any(c.isdigit() for c in password)
    has_upper = any(c.isupper() for c in password)
    has_lower = any(c.islower() for c in password)

    return has_digit and has_upper and has_lower

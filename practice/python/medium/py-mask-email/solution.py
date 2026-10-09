# Xom Data · Mask emails in the log
# Problem: https://xomdata.com/practice/py-mask-email
# Solved: 2026-10-09

def mask_email(email):
    local, domain = email.split('@')
    if len(local) <= 2:
        return email
    return local[:2] + '*' * (len(local) - 2) + '@' + domain

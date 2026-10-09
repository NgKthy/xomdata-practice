# Xom Data · Extract domain from email
# Problem: https://xomdata.com/practice/py-email-domain
# Solved: 2026-10-09

def get_domain(email):
    return email.split("@")[-1]
